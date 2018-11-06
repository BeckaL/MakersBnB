require 'sinatra/base'
require './user'
require './lib/listing'

class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
    @user = session[:current_user]
    erb :index
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    session[:current_user] = params["email"]
    password = params["password"]
    email = params["email"]
    User.add(email: email, password: password)
    redirect('/')
  end

  post '/sign_out' do
    session[:current_user] = nil
    redirect '/'
  end

  get '/new_listing' do
    erb :new_listing
  end

  post '/new_listing' do
    user = session[:current_user]
    name = params["name"]
    description = params["description"]
    price = params["price"]
    Listing.create(user: user, name: name, description: description, price: price)
    redirect('/listings')
  end

  get '/listings' do
    @listings = Listing.all
    erb :listings
  end

  run! if app_file == $0

end
