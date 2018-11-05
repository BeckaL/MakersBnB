require 'listing'

describe Listing do

  let (:listing) { Listing.new(listing_id: 1, user_id: 1, name: 'listing 1', description: 'big house', price: 100) }

  describe '.create' do
    it 'should insert a listing into the listing table in database' do
      Listing.create(name: 'listing 1', description: 'big house', price: 100)

      result = PG.connect(dbname: 'makers_bnb_test').exec('SELECT * FROM listings')

      expect(result[0]['listing_id'].to_i).to be_a Integer
      expect(result[0]['user_id'].to_i).to be_a Integer
      expect(result[0]['name']).to eq listing.name
      expect(result[0]['description']).to eq listing.description
      expect(result[0]['price'].to_f).to eq listing.price
    end
  end

  describe '.all' do

  end
end
