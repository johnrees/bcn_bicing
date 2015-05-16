require 'cgi'
class Station < ActiveRecord::Base
  has_many :recordings

  def total_slots
    bikes_count + slots_count
  end

  def to_s
    [street_name, street_number].compact.join(', ')
  end
end
