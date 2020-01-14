require 'uri'
require 'net/http'
require 'openssl'
require "json"
require_relative 'cuerpohtml'

def get_data(url)
url = URI(url)
http = Net::HTTP.new(url.host, url.port)
request = Net::HTTP::Get.new(url)
http.use_ssl =  true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.request(request)
JSON.parse(response.read_body)

end

clean_data = get_data ("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=jGjPvUgM7klVKhjGMYZNOyimurk8ZpYVtXkBcW2V")
picture_total = []
clean_data['photos'].each do |hash_info|

   picture_total << hash_info['camera']['name']
   end

grouped = picture_total.group_by {|x| x}

grouped.each do |k,v|
    grouped[k] = v.count
    end

puts grouped