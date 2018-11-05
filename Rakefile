require 'pg'

task :test_database_setup do
  p "Cleaning database..."

  connection = PG.connect(dbname: 'makers_bnb_test')

  # Clear the database
  connection.exec("TRUNCATE listings;")
  connection.exec("TRUNCATE users;")

  # Add the test data
  # connection.exec("INSERT INTO links VALUES(1, 'http://www.makersacademy.com');")
  # connection.exec("INSERT INTO links VALUES(2, 'http://www.google.com');")
  # connection.exec("INSERT INTO links VALUES(3, 'http://www.facebook.com');")
end

task :setup do
  p "Creating databases..."

  ['makers_bnb', 'makers_bnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE users(user_id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(20));")
    connection.exec("CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(user_id), name VARCHAR(60), description VARCHAR, price FLOAT4 );")
  end
end
