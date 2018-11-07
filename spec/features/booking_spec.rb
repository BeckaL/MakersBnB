feature do

  before do
    sign_up_generic_user
    create_new_generic_listing
  end

  it 'has a booking page' do
    pending
    click_link 'Beckas mansion'
    click_button 'request_to_book'
    expect(page).to have_field 'date'
    expect(page).to have_button 'submit'
  end

end
