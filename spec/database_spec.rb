require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'makers_bnb_test')
      DatabaseConnection.setup(dbname: 'makers_bnb_test')
    end
  end

  describe '.connection' do
    it 'connection should persist' do
      connection = DatabaseConnection.setup(dbname: 'makers_bnb_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end

  describe '.query' do
    it 'execute query via PG' do
      connection = DatabaseConnection.setup(dbname: 'makers_bnb_test')
      expect(connection).to receive(:exec).with("SELECT * FROM listings;")
      DatabaseConnection.query( "SELECT * FROM listings;")
    end
  end

end
