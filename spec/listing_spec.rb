require 'listing'

describe Listing do

  context 'listing created' do

    before do
      @listing = Listing.create(user: 'test@test.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    end

  describe '.create' do
    it 'should insert a listing into the listing table in database' do
      connection = DatabaseConnection.setup
      result = connection.query('SELECT * FROM listings')

      expect(result[0]['listing_id'].to_i).to be_a Integer
      expect(result[0]['user_id'].to_i).to be_a Integer
      expect(result[0]['name']).to eq 'listing+1'
      expect(result[0]['description']).to eq 'big+house'
      expect(result[0]['price'].to_f).to eq 100
      expect(result[0]['dates'].delete("{}").split(",")).to eq ['2019-01-01', '2019-01-05']
    end

  end

  describe '.all' do
    it 'should display all listings' do
      expect(Listing.all[0].listing_id.to_i).to be_a Integer
      expect(Listing.all[0].user_id.to_i).to be_a Integer
      expect(Listing.all[0].name).to eq CGI.unescape(@listing.name)
      expect(Listing.all[0].description).to eq CGI.unescape(@listing.description)
      expect(Listing.all[0].price.to_f).to eq @listing.price
      expect(Listing.all[0].dates).to eq ['2019-01-01', '2019-01-05']
    end
  end

  describe '.dates' do
    it 'should return available dates for specific listing' do
      expect(Listing.dates(listing_id: @listing.listing_id)).to eq ['2019-01-01', '2019-01-05']
    end
  end

  describe '.delete' do
    it 'should delete a specific listing' do
      Listing.delete(listing_id: @listing.listing_id)
      expect(Listing.find_by_id(listing_id: @listing.listing_id)).to be nil
    end
  end

end

end
