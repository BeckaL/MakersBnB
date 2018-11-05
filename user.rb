require 'pg'

class User

  def self.add(email:, password:)
    connection = connect_to_database
    connection.exec("INSERT INTO users (email, password) VALUES('#{email}', '#{password}')
    RETURNING user_id, email, password")
     return email
  end

  def self.all
    connection = connect_to_database
    data = connection.exec("SELECT email FROM users")
    data.map { |user| user['email'] }
  end

  private
  def self.connect_to_database
    return PG.connect :dbname => "makers_bnb_test" if ENV['RACK_ENV'] == "test"
    return PG.connect :dbname => "makers_bnb"
  end

end
