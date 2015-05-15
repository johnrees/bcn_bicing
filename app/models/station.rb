require 'cgi'
class Station < ActiveRecord::Base
  has_many :recordings
end
