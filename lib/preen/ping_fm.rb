require 'rubygems'
require 'pingfm'
require 'ick'

module Preen
  # Implements the Preen microblog protocol for Ping.fm.  Just a facade over the
  # +pingfm+ gem.
  class PingFm
    Ick::Returning.belongs_to self

    def initialize(user_key)
      @client = Pingfm::Client.new(Preen::PINGFM_API_KEY, user_key)
    end

    def post!(text)
      returning(@client.post(text)) do |result|
        if result[:status] == 'FAIL'
          raise result[:message]
        end
      end
    end
  end
end
