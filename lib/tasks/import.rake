require 'open-uri'
require 'ox'

namespace :import do

  desc "import data from bicing website"
  task :latest => :environment do

    # while true do
      url = "http://wservice.viabicing.cat/getstations.php?v=1"
      begin
        xml = Ox.parse(open(url).read)
      rescue SocketError
        next
      end
      poll_time = Time.at(xml.bicing_stations.locate("updatetime").first.nodes.first.value.to_i).utc

      changed_ids = []

      xml.bicing_stations.locate("station").each do |node|
        id = node.locate('id').first.text
        slots = node.locate('slots').first.text.to_i
        bikes = node.locate('bikes').first.text.to_i
        # p slots+bikes

        s = Station.unscoped.find_or_initialize_by(id: id).tap do |station|
          station.street_name = node.locate('street').first.nodes.first.value
          station.kind = node.locate('type').first.text
          station.latitude = node.locate('lat').first.text
          station.longitude = node.locate('long').first.text
          station.height = node.locate('height').first.text
          station.street_number = node.locate('streetNumber').first.text
          # station.nearby = node.locate('nearbyStationList').first.text
          station.status = node.locate('status').first.text
          station.slots_count = slots
          station.bikes_count = bikes
          station.last_polled_at = poll_time
        end

        changed_ids.push(id) if s.slots_count_changed? or s.bikes_count_changed?
        s.save

      end

      if changed_ids.any?
        changed_ids = changed_ids.join('/')
        puts changed_ids
        # `curl http://squirrul-faye.herokuapp.com/faye -d 'message={"channel":"/bikes", "data": "#{changed_ids}" }'`
      else
        puts "fail"
      end
    #   sleep(30)
    # end
  end
end
