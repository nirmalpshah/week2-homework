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

	json_string = open("http://api.openweathermap.org/data/2.5/weather?units=imperial&lat=#{geocode['lat']}&lon=#{geocode['lng']}").read

	json_obj = JSON.parse(json_string)

	temp = json_obj["main"]["temp"]

	puts 'Temperature: ' + temp.to_s + 'F'
rescue
        puts 'Uh oh, there was an issue... please try again.'
end

