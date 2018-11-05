require './user'

describe 'user' do
  before do
    User.add(email: "fakeemail@hotmail.com", password: "notarealpassword")
    User.add(email: "jamesbond@gmail.com", password: "007")
  end

    it 'can add user' do
      expect(User.all).to include "fakeemail@hotmail.com"
    end

    it "add another user" do
      expect(User.all).to eq ["fakeemail@hotmail.com", "jamesbond@gmail.com"]
    end

    it "add returns the users email" do
      expect(User.add(email: "fakeemail@hotmail.com", password: "notarealpassword")).to eq ("fakeemail@hotmail.com")
    end

end
