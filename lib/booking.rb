
class Booking

 def self.create(guest_id:, host_id:, listing_id:, date:)
   DatabaseConnection.setup

   result = DatabaseConnection.query("INSERT INTO bookings(guest_id, host_id, listing_id, date)
   VALUES ('#{guest_id}','#{host_id}','#{listing_id}', '#{date}')
   RETURNING booking_id, guest_id, host_id, listing_id, date")

 end
end
