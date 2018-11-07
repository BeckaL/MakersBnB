feature do

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

end
