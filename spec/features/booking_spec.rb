feature "Booking a space" do

  before do
    sign_up_generic_user
    create_new_generic_listing
  end

  it 'takes a booking for an available date' do
    click_link "Beckas mansion"
    click_link "request to book"
    select "2019-01-01", :from => "available dates"
    click_button 'submit'
    expect(page).to have_content 'booking request sent'
  end
  it "host can see booking request of their listing" do
    visit('/')
    click_button 'sign out'
    visit '/sign_up'
    fill_in 'email', with: "guest@mail.com"
    fill_in 'password', with: "guestpassword"
    click_button 'sign up'
    click_link 'Listings'
    click_link "Beckas mansion"
    click_link "request to book"
    select "2019-01-01", :from => "available dates"
    click_button 'submit'
    visit('/')
    click_button 'sign out'
    log_in_generic_user
    click_link 'Booking Requests'
    expect(page).to have_content "guest@mail.com"
    expect(page).to have_content "Beckas mansion"
    expect(page).to have_content "2019-01-01"
  end

end
