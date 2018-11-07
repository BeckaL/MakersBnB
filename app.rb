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

  get '/log_in' do
    erb :log_in
  end

  post '/log_in' do
    password = params["password"]
    email = params["email"]
    authentication = User.sign_in(email: email, password: password)
    if authentication
      session[:current_user] = email
      redirect('/')
    else
      redirect '/log_in'
    end
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

  run! if app_file == $0

end
