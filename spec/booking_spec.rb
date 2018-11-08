require 'booking'

describe 'Booking' do
  it 'creates new booking' do
    connection = DatabaseConnection.setup
    host = User.add(email: 'fakeemail@email.com', password: "1234")
    host_id = connection.query("SELECT user_id FROM users WHERE email = 'fakeemail@email.com';").first['user_id']
    guest = User.add(email: 'fake@email.com', password: "4321")
    guest_id = connection.query("SELECT user_id FROM users WHERE email = 'fake@email.com';").first['user_id']
    Listing.create(user: 'fakeemail@email.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    listing_id = connection.query("SELECT listing_id FROM listings WHERE name = 'listing+1';").first['listing_id']
    Booking.create(guest_id: guest_id, host_id: host_id, listing_id: listing_id, date: '2019-01-01')

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
    host_id = connection.query("SELECT user_id FROM users WHERE email = 'fakeemail@email.com';").first['user_id']
    guest = User.add(email: 'fake@email.com', password: "4321")
    guest_id = connection.query("SELECT user_id FROM users WHERE email = 'fake@email.com';").first['user_id']
    Listing.create(user: 'fakeemail@email.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    listing_id = connection.query("SELECT listing_id FROM listings WHERE name = 'listing+1';").first['listing_id']
    Booking.create(guest_id: guest_id, host_id: host_id, listing_id: listing_id, date: '2019-01-01')

    expect(Booking.all[0].booking_id.to_i).to be > 0
    expect(Booking.all[0].guest_id.to_i).to be > 0
    expect(Booking.all[0].host_id.to_i).to be > 0
    expect(Booking.all[0].listing_id.to_i).to be > 0
    expect(Booking.all[0].date).to eq '2019-01-01'

  end

  it 'selects all requests for a host' do
    connection = DatabaseConnection.setup
    host = User.add(email: 'fakeemail@email.com', password: "1234")
    host_id = connection.query("SELECT user_id FROM users WHERE email = 'fakeemail@email.com';").first['user_id']
    guest = User.add(email: 'fake@email.com', password: "4321")
    guest_id = connection.query("SELECT user_id FROM users WHERE email = 'fake@email.com';").first['user_id']
    Listing.create(user: 'fakeemail@email.com', name: 'listing 1', description: 'big house', price: '100', dates: ['2019-01-01', '2019-01-05'])
    listing_id = connection.query("SELECT listing_id FROM listings WHERE name = 'listing+1';").first['listing_id']
    Booking.create(guest_id: guest_id, host_id: host_id, listing_id: listing_id, date: '2019-01-01')
    result = Booking.select_by_host(host_id).first

    expect(result.guest_id).to eq guest_id.to_i
    expect(result.host_id).to eq host_id.to_i
    expect(result.listing_id).to eq listing_id.to_i
    expect(result.date).to eq '2019-01-01'
  end

  
end
