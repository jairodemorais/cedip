require 'rubygems'
require 'sinatra'
require 'data_mapper'
require './config/database'
require './helpers/sinatra'
require './models/User'
require 'erb'
require 'pony'

enable :sessions

get "/" do
  erb :index
end

post '/user/login' do
  if session[:user] = User.authenticate(params["username"], params["password"])
    flash("Sesion iniciada exitosamente.")
  else
    flash("Error al inicia sesion, vuelva a intentarlo.")
  end
  redirect '/'
end

get '/user/logout' do
  session[:user] = nil
  flash("Sesion finalizada.")
  redirect '/'
end

get "/noticias" do
  @news = New.all
	erb :noticias
end

get "/actividades" do
	erb :calendario
end

get "/contactos" do
  erb :contactos
end

post '/project/mail' do
  Pony.mail :to => 'jairodemorais@gmail.com',
            :from => params[:mail],
            :subject => "Un nuevo proyecto ha sido presentado por #{params[:name]}.",
            :body => "Descripcion del proyecto: #{params[:description]}. \n Datos de contacto: \n Mail: #{params[:mail]} \n Telefono: #{params[:phone]}"
  flash("Mail enviado.")
  redirect '/'
end

post '/news/create' do
  n = New.new
  n.title = params["title"]
  n.description = params["description"]
  n.link = params["link"].start_with?("http://") ? params["link"] : "http://#{params['link']}"

  if n.save
    flash("Noticia creada")
  else
    tmp = []
    n.errors.each do |e|
      tmp << (e.join("<br/>"))
    end
    flash(tmp)
  end
  redirect '/noticias'
end





