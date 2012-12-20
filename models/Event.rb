require 'dm-validations'

class Event
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :date, DateTime

  validates_presence_of :title
end