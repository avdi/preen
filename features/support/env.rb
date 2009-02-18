require 'fileutils'
require 'thread'
require 'webrick'

require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. .. spec spec_helper]))
require File.expand_path('stub_server', File.dirname(__FILE__))

ROOT        = File.expand_path('../..', File.dirname(__FILE__))
TMP         = File.join(ROOT,           'tmp')
TEST_HOME   = File.join(TMP,            'home')
BIN_DIR     = File.join(ROOT,           'bin')
PREEN_DIR   = File.join(TEST_HOME,      '.preen')
HTML_DIR    = File.join(ROOT, 'features', 'support', 'html')
REDDIT_PORT = 3131
PINGFM_PORT = 3133

TEST_ENV   = {
  'HOME'        => TEST_HOME,
  'PATH'        => BIN_DIR + ':' + ENV['PATH'],
  'REDDIT_HOST' => 'http://localhost:' + REDDIT_PORT.to_s,
  'PINGFM_HOST' => 'http://localhost:' + PINGFM_PORT.to_s
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

Before do
  @reddit = StubServer.new(REDDIT_PORT)
end

After do
end

at_exit do
end
