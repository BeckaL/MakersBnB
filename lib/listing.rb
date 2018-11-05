class Listing

  attr_reader :user_id, :name, :description, :price

  def initialize(user_id:, name:, description:, price:)
    @user_id = user_id
    @name = name
    @description = description
    @price = price
  end

end
