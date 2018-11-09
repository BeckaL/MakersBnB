require 'pg'
require './lib/database_connection'

class User

  attr_reader :user_id, :email

  def initialize(user_id:, email:)
    @user_id = user_id
    @email = email
  end

  def self.add(email:, password:)
    DatabaseConnection.setup
    return nil unless DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'").first.nil?
    DatabaseConnection.query("INSERT INTO users (email, password) VALUES('#{email}',
    '#{password}') RETURNING user_id, email, password")
    return email
  end

  def self.all
    DatabaseConnection.setup
    result = DatabaseConnection.query("SELECT * FROM users")
    result.map do |user|
      user_id = user['user_id']
      email = user['email']
      User.new(
        user_id: user_id,
        email: email
      )
    end
  end

  def self.sign_in(email:, password:)
    DatabaseConnection.setup
    data = DatabaseConnection.query("SELECT password FROM users WHERE email = '#{email}'").first
    return false if data == nil
    data['password'] == password
  end

  def self.find_by_id(user_id:)
    users = User.all
    @found_user = nil
    users.each do |user|
      if user.user_id.to_i == user_id
        @found_user = user
      end
    end
    @found_user.email
  end
end
