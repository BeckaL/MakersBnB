feature do

  before do
    sign_up_generic_user
    click_button('sign out')
  end

  it "logs in a user when the email and password is correct" do
    click_button('log in')
    fill_in 'email', with: "fakeemail@mail.com"
    fill_in 'password', with: "fakepassword"
    click_button('submit')
    expect(page).to have_content "Welcome to MakersBnB: fakeemail@mail.com"
  end

  it 'does not log in a user when the password is incorrect' do
    click_button('log in')
    fill_in 'email', with: "fakeemail@mail.com"
    fill_in 'password', with: "fakepasswor"
    click_button('submit')
    expect(page).to have_content 'email or password is incorrect'
  end

  it 'does not log in a user when the email is incorrect' do
    click_button('log in')
    fill_in 'email', with: "fakeemil@mail.com"
    fill_in 'password', with: "fakepassword"
    click_button('submit')
    expect(page).to have_content 'email or password is incorrect'
  end

end
