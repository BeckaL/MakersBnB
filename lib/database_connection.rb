require 'pg'

class DatabaseConnection

  def self.setup
    return @connection = PG.connect(dbname: "makers_bnb_test") if ENV['RACK_ENV'] == "test"
    return @connection = PG.connect(dbname: "makers_bnb")
  end

  def self.query(sql)
    @connection.exec(sql)
  end

end
