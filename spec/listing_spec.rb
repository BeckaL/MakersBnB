require 'listing'

describe Listing do
  describe '.create' do
    it 'should insert a listing into the listing table in database' do
      Listing.create(user: 'test@test.com', name: 'listing 1', description: 'big house', price: '100')

      result = PG.connect(dbname: 'makers_bnb_test').exec('SELECT * FROM listings')

      expect(result[0]['listing_id'].to_i).to be_a Integer
      expect(result[0]['user_id'].to_i).to be_a Integer
      expect(result[0]['name']).to eq 'listing 1'
      expect(result[0]['description']).to eq 'big house'
      expect(result[0]['price'].to_f).to eq 100
    end

  end

  describe '.all' do
    it 'should display all listings' do
      listing =  Listing.create(user: 'test@test.com', name: 'listing 1', description: 'big house', price: '100')

      expect(Listing.all[0].listing_id.to_i).to be_a Integer
      expect(Listing.all[0].user_id.to_i).to be_a Integer
      expect(Listing.all[0].name).to eq CGI.unescape(listing.name)
      expect(Listing.all[0].description).to eq CGI.unescape(listing.description)
      expect(Listing.all[0].price.to_f).to eq listing.price
    end
  end
end
