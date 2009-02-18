require File.join(File.dirname(__FILE__), %w[.. spec_helper])

describe Preen::Application do
  describe "given a data store" do
    before :each do
      @store = {
        'pingfm-key'  => '1234',
        'url-pattern' => 'http://example.com'
      }
      @it    = Preen::Application.new(@store)
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

    it "should be able to do a formatted dump of stored parameters" do
      @it.formatted_info.should ==
        "Ping.fm Key: 1234\n" \
        "URL Pattern: http://example.com\n\n"
    end
  end
end
