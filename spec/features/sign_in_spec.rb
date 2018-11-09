feature do

  before do
    sign_up_generic_user
    click_button('sign out')
  end

  it "logs in a user when the email and password is correct" do
    log_in_generic_user

    expect(page).to have_content "Welcome to MakersBnB: fakeemail@mail.com"
  end

  it 'does not log in a user when the password is incorrect' do
    log_in_generic_user(correct_password = false)

    expect(page).to have_content 'email or password is incorrect'
  end

  it 'does not log in a user when the email is incorrect' do
    log_in_generic_user(correct_email = false)
    
    expect(page).to have_content 'email or password is incorrect'
  end

end
