require 'pg'

task :setup do
  p "Creating databases..."

  ['makers_bnb', 'makers_bnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE users(user_id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(20));")
    connection.exec("CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(user_id), name VARCHAR(60), description VARCHAR, price FLOAT4, dates DATE[] );")
    connection.exec("CREATE TABLE bookings(booking_id SERIAL PRIMARY KEY, guest_id INTEGER REFERENCES users(user_id), host_id INTEGER REFERENCES users(user_id), listing_id INTEGER REFERENCES listings(listing_id), date VARCHAR, approved VARCHAR);")
  end
end
