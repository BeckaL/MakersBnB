require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './lib/booking'
require 'sinatra/flash'
require 'Date'
require './lib/helper_methods'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  include HelperMethods

  get '/' do
    erb :index
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    password = params["password"]
    email = params["email"]
    valid_sign_in = User.add(email: email, password: password)
    if !valid_sign_in
      flash[:notice] = "email is already taken!"
      redirect '/sign_up'
    else
      session[:current_user] = email
      redirect '/'
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
      redirect '/'
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
    name, description, price, dates = params["name"], params["description"],
    params["price"], params["dates"]
    if date_valid?(dates)
      dates = dates.split("\r\n")
      Listing.create(user: user, name: name, description: description,
      price: price, dates: dates)
      redirect '/listings'
    else
      flash[:notice] = 'please use YYYY-MM-DD format for dates'
      redirect '/new_listing'
    end
  end

  get '/listings' do
    @listings = Listing.all
    erb :listings
  end

  get '/listings/:listing_id' do
    @listing = Listing.find_by_id(listing_id: params[:listing_id])
    @user_email = User.find_by_id(user_id: @listing.user_id)
    erb :individual_listing
  end

  get '/listings/:listing_id/book' do
    @dates = Listing.dates(listing_id: params[:listing_id])
    @listing = Listing.find_by_id(listing_id: params[:listing_id])
    erb :book
  end

  post '/listings/:listing_id/book' do
    Booking.create(guest_email: session[:current_user],
    listing_id: params[:listing_id].to_i, date: params["available dates"])
    flash[:notice] = "booking request sent"
    redirect '/listings'
  end

  get '/listings/:listing_id/delete' do
    Listing.delete(listing_id: params[:listing_id])
    flash[:notice] = "listing deleted"
    redirect '/listings'
  end

  get '/booking_requests' do
    @requests = Booking.select_by_host(session[:current_user])
    erb :booking_requests
  end

  run! if app_file == $0

end
