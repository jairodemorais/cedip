require 'rubygems'
require 'dm-core'

DataMapper::Logger.new(STDOUT, :debug)

DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host => 'localhost',
    :username => 'root',
    :password => '',
    :database => 'cedip_development'})