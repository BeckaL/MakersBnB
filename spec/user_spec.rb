require 'user'

describe 'user' do
  before do
    User.add(email: "fakeemail@hotmail.com", password: "notarealpassword")
    User.add(email: "jamesbond@gmail.com", password: "007")
  end

  it 'can add user' do
    expect(User.all[0].email).to eq "test@test.com"
  end

  it "add another user" do
    expect(User.all[1].email).to eq "fakeemail@hotmail.com"
    expect(User.all[2].email).to eq "jamesbond@gmail.com"
  end

  it "add returns the users email" do
    expect(User.add(email: "jack@hotmail.com", password: "password")).to eq "jack@hotmail.com"
  end

  it 'can not add a user if the email is already datebase' do
    expect(User.add(email: "fakeemail@hotmail.com", password: "notarealpassword")).to eq nil
  end

  it 'can log in a user with the correct email and password' do
    expect(User.sign_in(email: "fakeemail@hotmail.com", password: "notarealpassword")).to eq true
  end

  it 'does not log in the user if the password is incorrect' do
    expect(User.sign_in(email: "fakeemail@hotmail.com", password: "isarealpassword")).to eq false
  end

  it 'does not log in if email is incorrect' do
    expect(User.sign_in(email: "realmail@hotmail.com", password: "notarealpassword")).to eq false
  end

end
