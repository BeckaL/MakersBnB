class Listing

  attr_reader :listing_id, :user_id, :name, :description, :price

  def initialize(listing_id:, user_id:, name:, description:, price:)
    @listing_id = listing_id
    @user_id = user_id
    @name = name
    @description = description
    @price = price
  end

  def self.create(user:, name:, description:, price:)
    # cleaning the user input to avoid some SQL problems,
    # remember to URI.unescape when reading back from
    # the database!
    name_string = CGI.escape(name)
    description_string = CGI.escape(description)
    price_string = price.gsub!(/[£$]/, "")

    result = connection.exec("INSERT INTO listings(user_id, name, description, price) VALUES ((SELECT user_id FROM users WHERE email = '#{user}'),'#{name_string}','#{description_string}','#{price_string}') RETURNING listing_id, user_id, name, description, price")

    listing_id = result.first["listing_id"].to_i
    user_id = result.first["user_id"].to_i
    name = result.first["name"]
    description = result.first["description"]
    price = result.first["price"].to_f

    Listing.new(listing_id: listing_id, user_id: user_id, name: name, description: description, price: price)
  end

  def self.all
    result = connection.exec("SELECT * FROM listings")
    result.map do |listing|
      Listing.new(
        listing_id: listing['listing_id'].to_i,
        user_id: listing['user_id'].to_i,
        name: CGI.unescape(listing['name']),
        description: CGI.unescape(listing['description']),
        price: listing['price'].to_f
      )
    end
  end

  private
  def self.connection
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'makers_bnb_test')
    else
      PG.connect(dbname: 'makers_bnb')
    end
  end
end
