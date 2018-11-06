class Listing

  attr_reader :listing_id, :user_id, :name, :description, :price

  def initialize(listing_id:, user_id:, name:, description:, price:)
    @listing_id = listing_id
    @user_id = user_id
    @name = name
    @description = description
    @price = price
  end

  def self.create(name:, description:, price:)
    result = DatabaseConnection.query("INSERT INTO listings(user_id, name, description, price) VALUES ((SELECT user_id FROM users WHERE email = 'test@test.com'),'#{name}','#{description}','#{price}') RETURNING listing_id, user_id, name, description, price")

    listing_id = result.first["listing_id"].to_i
    user_id = result.first["user_id"].to_i
    name = result.first["name"]
    description = result.first["description"]
    price = result.first["price"].to_f

    Listing.new(listing_id: listing_id, user_id: user_id, name: name, description: description, price: price)
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM listings")
    array = []
    result.map do |listing|
      Listing.new(
        listing_id: listing['listing_id'].to_i,
        user_id: listing['user_id'].to_i,
        name: listing['name'],
        description: listing['description'],
        price: listing['price'].to_f
      )
    end
  end

  # private
  def self.connection
    if ENV['RACK_ENV'] == 'test'
      DatabaseConnection.setup(dbname: 'makers_bnb_test')
    else
      DatabaseConnection.setup(dbname: 'makers_bnb')
    end
  end
end
