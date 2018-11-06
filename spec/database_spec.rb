require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'makers_bnb_test')
      DatabaseConnection.setup('makers_bnb_test')
    end
  end

  describe '.connection' do
    it 'connection should persist' do
      connection = DatabaseConnection.setup('makers_bnb_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end
  
end
