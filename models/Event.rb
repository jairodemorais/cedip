require 'dm-validations'

class Event
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :start_date, DateTime
  property :end_date, DateTime
  property :background_color, String
  property :fore_color, String

  validates_presence_of :title, :start_date, :end_date
end