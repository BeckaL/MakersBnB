require 'pg'

class User

  def self.add(email:, password:)
    raise "email taken!" unless DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'").first.nil? 
    DatabaseConnection.query("INSERT INTO users (email, password) VALUES('#{email}',
    '#{password}') RETURNING user_id, email, password")
    return email
  end

  def self.all
    data = DatabaseConnection.query("SELECT email FROM users")
    data.map { |user| user['email'] }
  end

  private

  def self.connect_to_database
    return DatabaseConnection.setup(dbname: "makers_bnb_test") if ENV['RACK_ENV'] == "test"
    return DatabaseConnection.setup(dbname: 'makers_bnb')
  end

end
