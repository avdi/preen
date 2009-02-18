require 'open-uri'

module Preen
  class Application
    REDDIT_FRONT_PAGE_PATH = "/r/programming/"

    def initialize(datastore)
      @datastore   = datastore
    end

    def init!(params)
      params.each_pair do |key, value|
        @datastore[key] = value.value
      end
    end

    def formatted_info
      "Ping.fm Key: #{@datastore['pingfm-key']}\n" \
      "URL Pattern: #{@datastore['url-pattern']}\n\n"
    end

    def scan!
      $stderr.puts "!!! Reading #{reddit_host + REDDIT_FRONT_PAGE_PATH}"
      open(reddit_host + REDDIT_FRONT_PAGE_PATH).read
    end

    private

    def reddit_host
      @datastore.fetch('REDDIT_HOST'){"http://www.reddit.com"}
    end

  end
end
