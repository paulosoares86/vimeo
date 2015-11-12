require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
end

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'vimeo'

require 'yaml'
SecretsFile = File.join(File.dirname(__FILE__), 'config', 'secrets.yml')
ACCESS_TOKEN = YAML.load_file(::SecretsFile)["access_token"]
if ACCESS_TOKEN == 'YOURACCESSTOKENHERE'
  $stderr.puts "ERROR: Please put your access token into #{SecretsFile} to run tests"
  exit 1
end

class Test::Unit::TestCase
  ACCESS_TOKEN = ::ACCESS_TOKEN
end
