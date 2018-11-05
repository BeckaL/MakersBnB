
require 'simplecov'
require 'simplecov-console'

require 'capybara/rspec'
require 'pg'
require 'simplecov'
require 'simplecov-console'
require 'capybara'
require 'rspec'
require './app'

# require File.join(File.dirname(__FILE__), '..', 'app.rb')

ENV['RACK_ENV'] = 'test'
Capybara.app = MakersBnB

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::Console
  ]
)
SimpleCov.start
#
RSpec.configure do |config|
  config.before(:each) do
    connection = PG.connect(dbname: 'makers_bnb_test')
    connection.exec("TRUNCATE listings, users;")
    connection.close
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
