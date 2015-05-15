class StaticController < ApplicationController
  layout false
  def map
    @stations = Station.pluck(:street_name, :latitude, :longitude, :bikes_count, :slots_count, :id)
  end
end
