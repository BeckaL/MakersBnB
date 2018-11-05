
require 'simplecov'
require 'simplecov-console'

require 'capybara/rspec'
require 'pg'
require 'simplecov'
require 'simplecov-console'
require 'capybara'
require 'rspec'
require 'rake'
require './app'

ENV['RACK_ENV'] = 'test'

Capybara.app = MakersBnB

RSpec.configure do |config|
  config.before(:each) do
    connection = PG.connect(dbname: 'makers_bnb_test')

    # Clear the database
    connection.exec("TRUNCATE listings, users;")


    # Add the test data
    connection.exec("INSERT INTO users (email, password) VALUES('test@test.com', 'password');")
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
