require 'open-uri'
require 'json'
require 'action_view'

include ActionView::Helpers::DateHelper

puts 'Enter an origin address: '
origin = gets.chomp
puts 'Enter an destination address: '
destination = gets.chomp

originEnc = URI::encode(origin)
destinationEnc = URI::encode(destination)

begin
	json_string = open("https://maps.googleapis.com/maps/api/directions/json?sensor=false&origin=#{originEnc}&destination=#{destinationEnc}").read
	json_obj = JSON.parse(json_string)

	legs = json_obj["routes"][0]["legs"]

	totalTime = 0
	totalDistance = 0
	legs.each do |leg|
		totalTime += leg["duration"]["value"]
		totalDistance += leg["distance"]["value"]
	end

	puts 'Total travel time: ' + distance_of_time_in_words(totalTime)
	puts 'Total distance: ' + (totalDistance / 1609).to_s + ' miles'
rescue
	puts 'Sorry, no info for you.  Try unplugging your microwave and resubmitting.'
end
