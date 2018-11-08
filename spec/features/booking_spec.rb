feature "Booking a space" do

  context 'user not signed in' do

    it 'should not have request-to-book-button if the user is not logged in' do
      expect(page).to have_no_button('request to book')
    end

  end

  context 'user signed in' do

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


end
