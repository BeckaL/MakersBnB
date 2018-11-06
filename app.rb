require 'sinatra/base'
require './lib/user'
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

  get '/listings/:listing_id' do
    @listing = Listing.find_by_id(listing_id: params[:listing_id])
    erb :individual_listing
  end

  get '/listings/:listing_id/book' do
    @listing = Listing.find_by_id(listing_id: params[:listing_id])
    erb :book
  end

  post '/listings/:listing_id/book' do
    redirect '/listings'
  end

  run! if app_file == $0

end
