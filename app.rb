require 'rubygems'
require 'sinatra'
require 'data_mapper'
require './config/database'
require './helpers/sinatra'
require './models/User'
require 'erb'
require 'pony'
require 'json'

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
	erb :calendario, :layout => false
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

get '/events/getAll' do
  content_type :json
  Event.all.to_json
end

post '/events/create' do
  content_type :json
  n = Event.new
  n.title = params["title"]
  n.start_date = params["startDate"]
  n.end_date = params["endDate"]
  n.background_color = params["bcolor"]
  n.fore_color = params["fcolor"]

  if n.save
    flash("Evento creado")
    n.to_json
  else
    status 400
    tmp = []
    n.errors.each do |e|
      tmp << (e.join("<br/>"))
    end
    flash(tmp)
    tmp.to_json
  end
end

post '/events/delete' do
  content_type :json
  n = Event.get(params["id"])
  if n.destroy
    flash("Evento eliminado")
  else
    status 404
    tmp = []
    n.errors.each do |e|
      tmp << (e.join("<br/>"))
    end
    flash(tmp).to_json
  end
end





