feature do

  before do
    sign_up_generic_user
  end

  it 'has a sign out button' do
    expect(page).to have_button "sign out"
  end

  it 'sign out button signs a user out' do
    click_button "sign out"
    expect(page).to have_content "Welcome to MakersBnB"
    expect(page).not_to have_content "fakeemail@mail.com"
  end

end
