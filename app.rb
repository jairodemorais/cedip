require 'rubygems'
require 'sinatra'
require 'data_mapper'
require './config/database'
require './helpers/sinatra'
require './models/User'
require 'erb'

enable :sessions

get "/" do
	@user = session[:user]
  erb :index
end

post '/user/login' do
  if session[:user] = User.authenticate(params["username"], params["password"])
    flash("Login successful")
  else
    flash("Login failed - Try again")
  end
  redirect '/'
end

get '/user/logout' do
  session[:user] = nil
  flash("Logout successful")
  redirect '/'
end

get "/noticias" do
	erb :noticias
end