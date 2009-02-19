require File.join(File.dirname(__FILE__), %w[.. spec_helper])

describe Preen::Application do
  describe "given a data store" do
    before :each do
      @store = {
        'pingfm-key'  => '1234',
        'url-pattern' => 'http://example.com',
        'posted-urls' => ['POSTED_URL_1']
      }

      @mention1   = stub("Mention 1", :comment_url => 'POSTED_URL_1')
      @mention2   = stub("Mention 2", :comment_url => 'REDDIT_URL_1')
      @mention3   = stub("Mention 3", :comment_url => 'REDDIT_URL_2')
      @mention4   = stub("Mention 4", :comment_url => 'REDDIT_URL_3')
      @mentions   = [@mention1, @mention2, @mention3, @mention4]
      @microblog  = stub("Microblog").as_null_object
      @news_site  = stub("NewsSite",
                         :scan_pages => @mentions,
                         :name       => "Reddit")
      @it      = Preen::Application.new(@store, @news_site, @microblog)
    end

    describe "and given the init command with required params" do
      before :each do
        @params = {
          'pingfm-key'  => stub('pingfm-key', :value => '6789'),
          'url-pattern' => stub('url-pattern',:value => 'test-pattern')
        }
      end

      after :each do
        @it.init!(@params)
      end

      it "should store the params" do
        @store.should_receive(:[]=).with('pingfm-key', '6789')
        @store.should_receive(:[]=).with('url-pattern', 'test-pattern')
      end
    end

    describe "and given the scan command" do
      it "should scan 3 pages of the news site for url pattern" do
        @news_site.should_receive(:scan_pages).
          with(3, "http://example.com").
          and_return([])
        @it.scan!
      end

      it "should post each news mention found to microblog" do
        @microblog.should_receive(:post!).with("I'm on Reddit: REDDIT_URL_1")
        @microblog.should_receive(:post!).with("I'm on Reddit: REDDIT_URL_2")
        @microblog.should_receive(:post!).with("I'm on Reddit: REDDIT_URL_3")
        @it.scan!
      end

      it "should not post any already-posted URLs" do
        @microblog.should_not_receive(:post!).
          with("I'm on Reddit: POSTED_URL_1")
        @it.scan!
      end

      it "should remember posted URLs" do
        @it.scan!
        @store['posted-urls'].should include("REDDIT_URL_1")
        @store['posted-urls'].should include("REDDIT_URL_2")
        @store['posted-urls'].should include("REDDIT_URL_3")
      end
    end

    it "should be able to do a formatted dump of stored parameters" do
      @it.formatted_info.should ==
        "Ping.fm Key: 1234\n" \
      "URL Pattern: http://example.com\n\n"
    end
  end

end
