feature "Viewing a listing page" do
  before do
    # Sign up and create new listing
    visit '/sign_up'
    fill_in 'email', with: "fakeemail@mail.com"
    fill_in 'password', with: "fakepassword"
    click_button 'submit'
    click_button 'create new listing'
    fill_in 'name', with: "Beckas mansion"
    fill_in 'description', with: "Ostentatiously big house"
    fill_in 'price', with: '1000'
    click_button 'submit'
  end

  it "shows the listing page" do
    click_link "Beckas mansion"
    expect(page).to have_content "Beckas mansion"
    expect(page).to have_content "Ostentatiously big house"
    expect(page).to have_content "1000"
  end
end
