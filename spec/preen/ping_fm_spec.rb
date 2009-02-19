require File.join(File.dirname(__FILE__), %w[.. spec_helper])

describe Preen::PingFm do
  describe "on init" do
    it "should initialize the client library with API and User keys" do
      Pingfm::Client.should_receive(:new).with(Preen::PINGFM_API_KEY,
                                               "FAKE_USER_KEY")
      Preen::PingFm.new("FAKE_USER_KEY")
    end
  end

  describe "given a user key" do
    before :each do
      @pingfm_client = stub("Pingfm::Client", :post => {:status => 'OK'})
      Pingfm::Client.stub!(:new).and_return(@pingfm_client)
      @user_key = "FAKE_USER_KEY"
      @it = Preen::PingFm.new(@user_key)
    end

    it "should be able to post to Ping.fm" do
      @pingfm_client.should_receive(:post)
      @it.post!("Hello, Ping.fm!")
    end

    it "should raise an error if a post attempt fails" do
      @pingfm_client.should_receive(:post).
        and_return(:status => 'FAIL', :message => "Error Message")
      lambda do
        @it.post!('Hello')
      end.should raise_error('Error Message')
    end
  end
end
