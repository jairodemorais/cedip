require 'rubygems'
require "bundler/setup"
require 'sinatra'
require 'data_mapper'
require 'dm-paperclip'
require './config/database'
require './helpers/sinatra'
require 'erb'
require 'pony'
require 'json'
require './models/User'
require './models/Event'
require './models/New'

enable :sessions
set :mail_user, 'userName'
set :mail_pass, 'password'
set :root, File.dirname(__FILE__)

Paperclip.options[:command_path] = "/opt/ImageMagick/bin"
get "/" do
  @news = New.all(:date.gte => Date.today - 7, :show => true)
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
  @news = New.all.reverse
	erb :noticias
end

get "/actividades" do
	erb :calendario
end

get "/contactos" do
  erb :contactos
end

get "/aboutus" do
  erb :nosotros
end

post '/project/mail' do
  Pony.mail :via => :smtp,
            :via_options => {
              :address        => 'smtp.gmail.com',
              :port           => '25',
              :user_name      => settings.mail_user,
              :password       => settings.mail_pass,
              :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
              :domain         => "HELO" # the HELO domain provided by the client to the server
            },
            :to => 'centrodeestudios.cedip@gmail.com',
            :from => params[:mail],
            :subject => "Un nuevo proyecto ha sido presentado por #{params[:name]}.",
            :body => "Descripcion del proyecto: #{params[:description]}. \n Datos de contacto: \n Mail: #{params[:mail]} \n Telefono: #{params[:phone]}"
  flash("Mail enviado.")
  redirect '/'
end

def make_paperclip_mash(file_hash)
  mash = {}
  mash['tempfile'] = file_hash[:tempfile]
  mash['filename'] = file_hash[:filename]
  mash['content_type'] = file_hash[:type]
  mash['size'] = file_hash[:tempfile].size
  mash
end

post '/news/create' do
  n = New.new
  n.title = params['title']
  n.description = params['description']
  n.link = params['link'].start_with?("http://") ? params['link'] : "http://#{params['link']}"
  n.date = Time.now
  n.photo = make_paperclip_mash(params['photo'])
  n.show = params['show'] == "on"

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





