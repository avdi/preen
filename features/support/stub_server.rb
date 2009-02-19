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

  # Prepare a new stub server to run on +port+
  def initialize(port, pages = [])
    @port      = port
    @pages     = pages
    @requests = []
  end

  # Adds a page mounting on the stub server.  Any request which === +path+ will
  # trigger a response with the given +body+, +status+, and +headers+
  def add_page(path, body, status=200, headers={})
    @pages << {
      'path'    => path,
      'body'    => body,
      'status'  => status,
      'headers' => headers
    }
  end

  # Runs the provided block with a stub server running in the background, ready
  # to receive requests.
  def run
    Open4.popen4(STUBSERVER_EXEC) do |pid, stdin, stdout, stderr|
      timeout(3) do
        stdin.write(config_yaml)
        stdin.close
        line = stdout.gets until line =~ /listening/i
        yield
        Process.kill("QUIT", pid)
        process_log(stdout, pid)
      end
    end
  end

  # Returns true if the stub server has received a request matching +pattern+,
  # where +pattern+ is a hash of keys corresponding to Rack::Request attributes
  # and values which will be matched (using #===) against the attribute values.
  #
  # E.g. { :path_info => /index.html$/ } would match any request for a path
  # ending in "index.html"
  #
  # Note: currently only valid after a call to #run() has completed.
  def has_received_request?(pattern)
    requests.detect{ |request|
      pattern.all?{|attribute, value|
        value === request.send(attribute)
      }
    }
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

  def process_log(stdout, pid)
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
