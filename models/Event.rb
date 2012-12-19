class Event
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :date, DateTime
end