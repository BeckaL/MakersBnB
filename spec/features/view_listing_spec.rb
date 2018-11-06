feature "Viewing a listing page" do
  before do
    sign_up_generic_user
    create_new_generic_listing
  end

  it "shows the listing page" do
    click_link "Beckas mansion"
    expect(page).to have_content "Beckas mansion"
    expect(page).to have_content "Ostentatiously big house"
    expect(page).to have_content "1000"
  end
end
