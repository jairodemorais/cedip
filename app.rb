require 'rubygems'
require 'sinatra'
require 'data_mapper'
require './config/database'
require './helpers/sinatra'
require './models/User'

get "/" do
  File.read(File.join('public', 'views', 'index.html'))
end

post '/user/login' do
  if session[:user] = User.authenticate(params["username"], params["password"])
    flash("Login successful")
    redirect '/noticias'
  else
    flash("Login failed - Try again")
    redirect '/'
  end
end

get "/noticias" do
  File.read(File.join('public', 'views', 'noticias.html'))
end