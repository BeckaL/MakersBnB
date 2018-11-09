require 'booking'

describe 'Booking' do
  it 'creates new booking' do

    connection = DatabaseConnection.setup
    host = User.add(email: 'fakeemail@email.com', password: "1234")
    guest = User.add(email: 'fake@email.com', password: "4321")
    guest_email = 'fake@email.com'
    Listing.create(user: 'fakeemail@email.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    listing_id = connection.query("SELECT listing_id FROM listings WHERE name = 'listing+1';").first['listing_id']
    Booking.create(guest_email: guest_email, listing_id: listing_id, date: '2019-01-01')
    result = connection.query('SELECT * FROM bookings')

    expect(result[0]['booking_id'].to_i).to be > 0
    expect(result[0]['guest_id'].to_i).to be > 0
    expect(result[0]['host_id'].to_i).to be > 0
    expect(result[0]['listing_id'].to_i).to be > 0
    expect(result[0]['date']).to eq '2019-01-01'

  end

  it ".all should display booking request" do
    connection = DatabaseConnection.setup
    host = User.add(email: 'fakeemail@email.com', password: "1234")
    guest = User.add(email: 'fake@email.com', password: "4321")
    guest_email = 'fake@email.com'
    Listing.create(user: 'fakeemail@email.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    listing_id = connection.query("SELECT listing_id FROM listings WHERE name = 'listing+1';").first['listing_id']
    Booking.create(guest_email: guest_email, listing_id: listing_id, date: '2019-01-01')

    expect(Booking.all[0].booking_id.to_i).to be > 0
    expect(Booking.all[0].guest_id.to_i).to be > 0
    expect(Booking.all[0].host_id.to_i).to be > 0
    expect(Booking.all[0].listing_id.to_i).to be > 0
    expect(Booking.all[0].date).to eq '2019-01-01'

  end

  it 'selects all requests for a host' do

    connection = DatabaseConnection.setup
    host = User.add(email: 'host@gmail.com', password: "1234")
    host_id = connection.query("SELECT user_id FROM users WHERE email = 'host@gmail.com';").first["user_id"].to_i
    guest = User.add(email: 'guest@gmail.com', password: "4321")
    guest_id = connection.query("SELECT user_id FROM users WHERE email = 'guest@gmail.com';").first["user_id"].to_i
    guest_email = 'guest@gmail.com'
    Listing.create(user: 'host@gmail.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    listing_id = connection.query("SELECT listing_id FROM listings WHERE name = 'listing+1';").first['listing_id']
    Booking.create(guest_email: guest_email, listing_id: listing_id, date: '2019-01-01')

    result = Booking.select_by_host('host@gmail.com').first

    expect(result["guest_email"]).to eq guest_email
    expect(result["listing_name"]).to eq "listing 1"
    expect(result["date"]).to eq '2019-01-01'
  end


end
