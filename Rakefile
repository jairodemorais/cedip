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

namespace :db do
  require './config/database'

  desc "Migrate the database"
  task :migrate do
    DataMapper.auto_migrate!
  end
  
  desc "Add some test users"
  task :testdata do
    us = User.new
    us.login = "test"
    us.email = "asdf@asdf.de"
    us.password = "pw"
    us.save

    as = User.new
    as.login = "foo"
    as.email = "yes@asd.de"
    as.password = "bar"
    as.save

    ev = Event.new
    ev.title = "event"
    ev.start_date = Time.now
    ev.end_date = Time.now
    ev.save

    nw = New.new
    nw.title = "the new new new"
    nw.show = false
    nw.description = "La description es muy corta papa"
    nw.link = "www.facebook.com.ar"
    nw.save
  end    
end
    
