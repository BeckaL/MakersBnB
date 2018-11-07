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


end
