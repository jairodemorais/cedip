require 'dm-validations'

class New
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :link, String

  validates_presence_of :title, :description
end