class StationsController < ApplicationController
  layout false
  def show
    @station = Station.find(params[:id])

    @readings = @station.recordings.map{|r| {x: r.polled_at.to_i, y: r.bikes_count } }
  end
end
