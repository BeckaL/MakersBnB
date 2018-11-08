
class Booking
  attr_reader :booking_id, :guest_id, :host_id, :listing_id, :date

  def initialize(booking_id:, guest_id:, host_id:, listing_id:, date:)
    @booking_id = booking_id
    @guest_id = guest_id
    @host_id = host_id
    @listing_id = listing_id
    @date = date
  end

  def self.create(guest_email:, listing_id:, date:)
    DatabaseConnection.setup
    guest_id = DatabaseConnection.query("SELECT user_id FROM users WHERE email = '#{guest_email}'").first["user_id"].to_i
    host_id = DatabaseConnection.query("SELECT user_id FROM listings WHERE listing_id = '#{listing_id}'").first["user_id"].to_i
    result = DatabaseConnection.query("INSERT INTO bookings(guest_id, host_id, listing_id, date)
    VALUES ('#{guest_id}','#{host_id}','#{listing_id}', '#{date}')
    RETURNING booking_id, guest_id, host_id, listing_id, date")
  end

  def self.all
    DatabaseConnection.setup
    result = DatabaseConnection.query("SELECT * FROM bookings")
    result.map do |request|
      Booking.new(
        booking_id: request['booking_id'].to_i,
        guest_id: request['guest_id'].to_i,
        host_id: request['host_id'].to_i,
        listing_id: request['listing_id'].to_i,
        date: request['date']
      )
    end
  end

  def self.select_by_host(host_email)
    DatabaseConnection.setup
    host_id = DatabaseConnection.query("SELECT user_id FROM users WHERE email = '#{host_email}'").first["user_id"]
    booking_requests = self.all
    booking_requests.select! do |booking|
      booking.host_id == host_id.to_i
    end
    booking_requests
  end


end
