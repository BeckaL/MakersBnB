feature do

  context 'user is not signed in' do

    it 'should not have create-new-listing-button if the user is not logged in' do
      expect(page).to have_no_button('create new listing')
    end

  end

  context 'user is signed in' do

    before do
      sign_up_generic_user
    end

    it 'has a new listing page' do
      click_button 'create new listing'
      expect(page).to have_field "name"
      expect(page).to have_field "description"
      expect(page).to have_field "price"
    end

    it 'creates a new listing' do
      create_new_generic_listing
      expect(page).to have_content "Beckas mansion"
    end

    it 'creates two listings' do
      create_new_generic_listing
      create_new_listing("An MP's second home", "Happily bought on taxpayer dollar", '5000', '2019-01-01')

      expect(page).to have_content "Beckas mansion"
      expect(page).to have_content "An MP's second home"
    end

    it "shows the listing page" do
      create_new_generic_listing
      click_link "Beckas mansion"
      expect(page).to have_content "Beckas mansion"
      expect(page).to have_content "Ostentatiously big house"
      expect(page).to have_content "1000"
    end

    it "does not let user create a listing when date is formatted incorrectly" do
      create_new_listing('Beckas mansion', 'Ostentatiously big house', '1000', '1st January 2019')
      expect(page).to have_content "please use YYYY-MM-DD format for dates"
    end

  end

end
