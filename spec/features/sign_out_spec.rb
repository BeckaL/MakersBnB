feature do

  before do
    visit'/sign_up'
    fill_in 'email', with: "fakeemail@mail.com"
    fill_in 'password', with: "fakepassword"
    click_button 'submit'
  end

  it 'has a sign out button' do
    expect(page).to have_button ("sign out")
  end

  it 'sign out button signs a user out' do
    click_button("sign out")
    expect(page).to have_content("Welcome to MakersBnB")
    expect(page).not_to have_content("fakeemail@mail.com")
  end

end
