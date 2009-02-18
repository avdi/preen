require 'yaml'
require 'rubygems'
require 'rack'
require 'pathname'
require 'open4'
require 'timeout'

class StubServer
  include Timeout

  # Represents an error in the slave server
  class ServerError < RuntimeError
  end

  STUBSERVER_EXEC = File.expand_path('stubserver', File.dirname(__FILE__))

  attr_reader :requests

  def initialize(port, pages = [])
    @port      = port
    @pages     = pages
    @requests = []
  end

  def add_page(path, body, status=200, headers={})
    @pages << {
      'path'    => path,
      'body'    => body,
      'status'  => status,
      'headers' => headers
    }
  end

  def run
    Open4.popen4(STUBSERVER_EXEC) do |pid, stdin, stdout, stderr|
      timeout(3) do
        stdin.write(config_yaml)
        stdin.close
        line = stdout.gets until line =~ /listening/i
        yield
        Process.kill("QUIT", pid)
        YAML.each_document(stdout) do |log_entry|
          case (type = log_entry.delete('stubserver-log-type'))
          when 'env'
            @requests << Rack::Request.new(log_entry)
          when 'error'
            raise(ServerError,
                  "stubserver #{pid} failed with " \
                  "#{log_entry['class']}: #{log_entry['message']}}")
          else
            raise "Unkown stubserver log entry type: #{type.inspect}"
          end
        end
      end
    end
  end

  private

  def config_yaml
    config = {
      'pages'   => @pages,
      'address' => '0.0.0.0',
      'port'    => @port
    }
    YAML.dump(config)
  end
end
