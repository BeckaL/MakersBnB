require 'pg'

class DatabaseConnection

  def self.setup
    return @connection = PG.connect(dbname: "makers_bnb_test") if test?
    
    return @connection = PG.connect(dbname: "makers_bnb")
  end

  def self.query(sql)
    @connection.exec(sql)
  end

  def self.test?
    ENV['RACK_ENV'] == "test"
  end

end
