require File.join(File.dirname(__FILE__), %w[.. spec_helper])

describe Preen::Reddit, "given a home url and a URL fetcher" do
  HTML_DIR       = File.expand_path("../html", File.dirname(__FILE__))
  HTML_DIR_URL   = "file://#{HTML_DIR}"
  FRONT_PAGE_URL = "#{HTML_DIR_URL}/front_page.html"

  ARTICLE1_URL = "http://www.reddit.com/r/programming/comments/john_doe_article_1"
  ARTICLE2_URL = "http://www.reddit.com/r/programming/comments/john_doe_article_2"
  ARTICLE3_URL = "http://www.reddit.com/r/programming/comments/john_doe_article_3"
  ARTICLE4_URL = "http://www.reddit.com/r/programming/comments/john_doe_article_4"

  URL_PATTERN  = %r[http://johndoe.example.com/]

  before :each do
    @log = stub("Log").as_null_object
    @it = Preen::Reddit.new(FRONT_PAGE_URL, @log)
  end

  after :each do
  end

  describe "asked to scan 2 pages for a URL pattern" do
    def get_mentions
      @it.scan_pages(1, URL_PATTERN)
    end

    it "should return 1 mention" do
      get_mentions.should have(1).item
    end

    it "should return the mention from the front page" do
      get_mentions.first.comment_url.should == ARTICLE1_URL
    end
  end

  describe "asked to scan 3 pages for a URL pattern" do
    before :each do
      @mentions = get_mentions
    end

    def get_mentions
      @it.scan_pages(3, URL_PATTERN)
    end

    it "should return 4 mentions" do
      @mentions.should have(4).items
    end

    it "should return the mention from the front page" do
      @mentions.map{|m| m.comment_url}.should include(ARTICLE1_URL)
    end

    it "should return both mentions from the third page" do
      @mentions.map{|m| m.comment_url}.should include(ARTICLE2_URL)
      @mentions.map{|m| m.comment_url}.should include(ARTICLE3_URL)
    end

    it "should not return mentions from the fourth page" do
      @mentions.map{|m| m.comment_url}.should_not include(ARTICLE4_URL)
    end

  end

end
