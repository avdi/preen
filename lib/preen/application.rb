require 'open-uri'

module Preen
  class Application
    REDDIT_FRONT_PAGE_PATH = "/r/programming/"

    # An error stemming from a problem with the data store initialization
    class InitError < RuntimeError
    end

    def initialize(datastore, news_site, microblog)
      @datastore   = datastore
      @news_site   = news_site
      @microblog   = microblog
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
      @news_site.scan_pages(3, url_pattern).each do |mention|
        unless already_posted_url?(mention.comment_url)
          @microblog.post!("I'm on #{@news_site.name}: #{mention.comment_url}")
          remember_url(mention.comment_url)
        end
      end
    end

    private

    def reddit_host
      @datastore.fetch('REDDIT_HOST'){"http://www.reddit.com"}
    end

    def url_pattern
      @datastore.fetch('url-pattern'){raise InitError, "No url pattern found!"}
    end

    def already_posted_url?(url)
      posted_urls.include?(url)
    end

    def remember_url(url)
      posted_urls << url
    end

    def posted_urls
      @datastore['posted-urls'] ||= []
    end

  end
end
