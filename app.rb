require 'sinatra/base'
require './user'

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

  run! if app_file == $0

end
