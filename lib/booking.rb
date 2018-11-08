
class Booking

 def self.create(guest_id:, host_id:, listing_id:, date:)
   DatabaseConnection.setup

   result = DatabaseConnection.query("INSERT INTO bookings(guest_id, host_id, listing_id, date)
   VALUES ('#{guest_id}','#{host_id}','#{listing_id}', '#{date}')
   RETURNING booking_id, guest_id, host_id, listing_id, date")
 end

 def self.all
   DatabaseConnection.setup
   result = DatabaseConnection.query("SELECT * FROM bookings")
   result.map do |request|
     name = CGI.unescape(request['name'])
     description = CGI.unescape(request['description'])
     Booking.new(
       booking_id: listing['listing_id'].to_i,
       guest_id: listing['user_id'].to_i,
       host_id: name,
       listing_id: [',
       dates: reqest['dates']
 end

end
