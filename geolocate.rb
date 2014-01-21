require 'open-uri'
require 'json'

puts 'Enter an address, city or zipcode: '
location = gets
location = location.chomp
locationEnc = URI::encode(location)

begin
	json_string = open("https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{locationEnc}").read
	json_obj = JSON.parse(json_string)

	geocode = json_obj["results"][0]["geometry"]["location"];

	puts 'Latitude: ' + geocode["lat"].to_s
	puts 'Longitude: ' + geocode["lng"].to_s
rescue
	puts 'Where do you live, the moon? Couldn\'t find ' + location
end
