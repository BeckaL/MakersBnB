require 'date'

describe "can read dates from database" do
  it "can read dates from database" do
    connection = PG.connect(dbname: 'makers_bnb')
    result = connection.exec("SELECT * FROM listings_experiment")
    # p result[0]
    date_array = result[0]["date"].delete("{}").split(",")
    date_array.each do |date_string|
      # date = Date.parse(date_string)
      # puts date.year
      # puts date.month
      # puts date.day
    end
  end
end
