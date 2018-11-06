require 'pg'
require './lib/database_connection'

class User

  def self.add(email:, password:)
    DatabaseConnection.setup
    raise "email taken!" unless DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'").first.nil?
    DatabaseConnection.query("INSERT INTO users (email, password) VALUES('#{email}',
    '#{password}') RETURNING user_id, email, password")
    return email
  end

  def self.all
    DatabaseConnection.setup
    data = DatabaseConnection.query("SELECT email FROM users")
    data.map { |user| user['email'] }
  end

end
