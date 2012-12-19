require 'rubygems'
require 'dm-core'
require './models/User'

DataMapper::Logger.new(STDOUT, :debug)

DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host => 'localhost',
    :username => 'root',
    :password => '',
    :database => 'cedip_development'})