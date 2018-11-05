require 'listing'

describe Listing do

  describe '.create' do

    it 'should create a listing with user id, name, description and price' do
      listing = Listing.new(user_id: 123, name: 'listing 1', description: 'big house', price: 100)
      expect(listing.user_id).to eq 123
      expect(listing.name).to eq 'listing 1'
      expect(listing.description).to eq 'big house'
      expect(listing.price).to eq 100
    end

  end

end
