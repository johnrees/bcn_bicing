class StationsController < ApplicationController
  layout false
  def show
    @station = Station.find(params[:id])

    @readings = @station.recordings.order('polled_at asc').where('polled_at > ?', (params[:hours].try(:to_i) || 4).hours.ago).map{|r| {x: r.polled_at.to_i, y: r.bikes_count } }
  end
end
