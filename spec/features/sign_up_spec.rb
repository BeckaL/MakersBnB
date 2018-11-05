feature do
  it 'has a sign up page' do
    visit '/sign_up'
    expect(page).to have_field ("email")
    expect(page).to have_field ("password")
    expect(page).to have_button ("submit")
  end

  it "signs up a user" do
    visit'/sign_up'
    fill_in 'email', with: "fakeemail@mail.com"
    fill_in 'password', with: "fakepassword"
    click_button 'submit'
    expect(page).to have_content "Welcome to MakersBnB: fakeemail@mail.com"

  end

end
