def sign_up_generic_user
  visit '/sign_up'
  fill_in 'email', with: "fakeemail@mail.com"
  fill_in 'password', with: "fakepassword"
  click_button 'submit'
end

def create_new_generic_listing
  click_button 'create new listing'
  fill_in 'name', with: "Beckas mansion"
  fill_in 'description', with: "Ostentatiously big house"
  fill_in 'price', with: '1000'
  fill_in 'dates', with: '2019-01-01'
  click_button 'submit'
end

def create_new_listing(name, description, price, dates)
  click_button 'create new listing'
  fill_in 'name', with: name
  fill_in 'description', with: description
  fill_in 'price', with: price
  fill_in 'dates', with: dates
  click_button 'submit'
end
