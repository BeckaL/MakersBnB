def sign_up_generic_user
  visit '/sign_up'
  fill_in 'email', with: "fakeemail@mail.com"
  fill_in 'password', with: "fakepassword"
  click_button 'sign up'
end

def log_in_generic_user(correct_email = true, correct_password = true)
  email = correct_email ? "fakeemail@mail.com" : "wrongemail@mail.com"
  password = correct_password ? "fakepassword" : "wrongpassword"
  click_button('log in')
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button('log in')
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
