require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'makers_bnb_test')
      DatabaseConnection.setup
    end
  end

  describe '.query' do
    it 'execute query via PG' do
      connection = DatabaseConnection.setup
      expect(connection).to receive(:exec).with("SELECT * FROM listings;")
      DatabaseConnection.query( "SELECT * FROM listings;")
    end
  end

end
