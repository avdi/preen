require 'rubygems'
require 'pingfm'
require 'ick'
require 'logger'

module Preen
  # Implements the Preen microblog protocol for Ping.fm.  Just a facade over the
  # +pingfm+ gem.
  class PingFm
    Ick::Returning.belongs_to self

    def initialize(user_key, log=Logger.new($stderr))
      @client = Pingfm::Client.new(Preen::PINGFM_API_KEY, user_key)
      @log    = log
    end

    def post!(text)
      @log.info "Posting #{text} to Ping.fm"
      returning(@client.post(text)) do |result|
        if result[:status] == 'FAIL'
          raise result[:message]
        end
      end
    end
  end
end
