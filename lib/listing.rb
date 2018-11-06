require './lib/database_connection'

class Listing

  attr_reader :listing_id, :user_id, :name, :description, :price

  def initialize(listing_id:, user_id:, name:, description:, price:)
    @listing_id = listing_id
    @user_id = user_id
    @name = name
    @description = description
    @price = price
  end

  def self.find_by_id(listing_id:)
    listings = Listing.all
    @found_listing = nil
    listings.each do |listing|
      if listing.listing_id == listing_id.to_i
        @found_listing = listing
      end
    end
    @found_listing
  end

  def self.create(user:, name:, description:, price:)
    # cleaning the user input to avoid some SQL problems,
    # remember to CGI.unescape when reading back from
    # the database in self.all
    name_string = CGI.escape(name)
    description_string = CGI.escape(description)
    price.gsub!(/[£$]/, "")

    result = DatabaseConnection.query("INSERT INTO listings(user_id, name, description, price) VALUES ((SELECT user_id FROM users WHERE email = '#{user}'),'#{name_string}','#{description_string}','#{price}') RETURNING listing_id, user_id, name, description, price")

    listing_id = result.first["listing_id"].to_i
    user_id = result.first["user_id"].to_i
    name = result.first["name"]
    description = result.first["description"]
    price = result.first["price"].to_f

    Listing.new(listing_id: listing_id, user_id: user_id, name: name, description: description, price: price)
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM listings")
    result.map do |listing|
      name = CGI.unescape(listing['name'])
      description = CGI.unescape(listing['description'])
      Listing.new(
        listing_id: listing['listing_id'].to_i,
        user_id: listing['user_id'].to_i,
        name: name,
        description: description,
        price: listing['price'].to_f
      )
    end
  end
end
