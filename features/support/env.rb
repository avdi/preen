require 'fileutils'
require 'thread'
require 'webrick'
require 'pingfm'

require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. .. spec spec_helper]))
require File.expand_path('stub_server', File.dirname(__FILE__))

ROOT        = File.expand_path('../..', File.dirname(__FILE__))
TMP         = File.join(ROOT,           'tmp')
TEST_HOME   = File.join(TMP,            'home')
BIN_DIR     = File.join(ROOT,           'bin')
PREEN_DIR   = File.join(TEST_HOME,      '.preen')
HTML_DIR    = File.join(ROOT, 'features', 'support', 'html')
REDDIT_PORT = 3134
PINGFM_PORT = 3133

PINGFM_USER_KEY = "FAKEUSERKEY"

TEST_ENV   = {
  'HOME'        => TEST_HOME,
  'PATH'        => BIN_DIR + ':' + ENV['PATH'],
  'REDDIT_URL'  => 'http://localhost:' + REDDIT_PORT.to_s,
  'PINGFM_URL'  => 'http://localhost:' + PINGFM_PORT.to_s + '/v1'
}

FileUtils.mkdir_p TEST_HOME

def with_env(new_env)
  old_env = {}
  new_env.keys.each do |key|
    old_env[key] = ENV[key]
    ENV[key] = new_env[key]
  end
  yield
  new_env.keys.each do |key|
    ENV[key] = old_env[key]
  end
end

def with_test_env
  with_env(TEST_ENV) do
    Dir.chdir(TEST_HOME) do
      yield
    end
  end
end

def make_pingfm_request_pattern(reddit_path)
  {
    :path_info => '/v1/user.post',
    :params => {
      'api_key'      => Preen::PINGFM_API_KEY,
      'user_app_key' => PINGFM_USER_KEY,
      'post_method'  => 'default',
      'body'         => /I'm on Reddit: .*#{reddit_path}/
    }
  }
end

Before do
  @reddit = StubServer.new(REDDIT_PORT)
  @pingfm = StubServer.new(PINGFM_PORT)
  @pingfm.add_page('/v1/user.post',<<-END)
    <?xml version="1.0"?>
    <rsp status="OK">
      <transaction>12345</transaction>
      <method>user.post</method>
    </rsp>
  END
end

After do
end

at_exit do
end
