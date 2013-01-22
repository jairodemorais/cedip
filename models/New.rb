require 'dm-validations'

class New
  include DataMapper::Resource
  include Paperclip::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :link, String
  property :show, Boolean
  property :date, Date
  has_attached_file :photo,
                    :styles => {
                      :thumb=> "50x45#",
                      :medium => "110x100>",
                      :large =>  "250x250>}"
                    },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => "#{settings.root}/public/system/:attachment/:id/:style/:basename.:extension"

  validates_presence_of :title, :description
end