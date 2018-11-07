require 'sinatra/base'
require './lib/user'
require './lib/listing'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @user = session[:current_user]
    erb :index
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    password = params["password"]
    email = params["email"]
    valid_sign_in = User.add(email: email, password: password)
    if valid_sign_in == nil
      flash[:notice] = "email is already taken!"
      redirect '/sign_up'
    else
      session[:current_user] = email
      redirect('/')
    end
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
      flash[:notice] = "email or password is incorrect"
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
    dates = params["dates"].split("\r\n")
    Listing.create(user: user, name: name, description: description, price: price, dates: dates)
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
    @dates = Listing.dates(listing_id: params[:listing_id])
    @listing = Listing.find_by_id(listing_id: params[:listing_id])
    erb :book
  end

  post '/listings/:listing_id/book' do
    p params
    flash[:notice] = "booking request sent"
    redirect '/listings'
  end

  run! if app_file == $0

end
