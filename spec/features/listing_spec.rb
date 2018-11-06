feature do

  before do
    visit'/sign_up'
    fill_in 'email', with: "fakeemail@mail.com"
    fill_in 'password', with: "fakepassword"
    click_button 'submit'
    visit '/new_listing'
  end

  it 'has a new listing page' do
    expect(page).to have_field "name"
    expect(page).to have_field "description"
    expect(page).to have_field "price"
  end

  it 'creates a new listing' do
    fill_in 'name', with: "Becka's mansion"
    fill_in 'description', with: "Ostentatiously big house"
    fill_in 'price', with: '1000'
    click_button 'submit'
    expect(page).to have_content "Becka's mansion"
  end

  it 'creates two listings' do
    fill_in 'name', with: "Becka's mansion"
    fill_in 'description', with: "Ostentatiously big house"
    fill_in 'price', with: '1000'
    click_button 'submit'
    visit '/new_listing'
    fill_in 'name', with: "An MP's second home"
    fill_in 'description', with: "Happily bought on taxpayer dollar"
    fill_in 'price', with: '5000'
    click_button 'submit'
    expect(page).to have_content "Becka's mansion"
    expect(page).to have_content "An MP's second home"
  end

end
