require 'rubygems'
require 'pingfm'

module Preen
  # Implements the Preen microblog protocol for Ping.fm.  Just a facade over the
  # +pingfm+ gem.
  class PingFm
    def initialize(user_key)
      @client = Pingfm::Client.new(Preen::PINGFM_API_KEY, user_key)
    end

    def post!(text)
      @client.post(text)
    end
  end
end
