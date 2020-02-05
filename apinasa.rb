require 'uri'
require 'net/http'
require 'openssl'
require "json"
require_relative 'buid_web_page'

def get_data(url)
    url = URI(url)
http = Net::HTTP.new(url.host, url.port)
request = Net::HTTP::Get.new(url)
http.use_ssl =  true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.request(request)
JSON.parse(response.read_body)

end

clean_data = get_data ("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=jGjPvUgM7klVKhjGMYZNOyimurk8ZpYVtXkBcW2V")





File.open('nasa.html','w') do |f|
    
    f.puts head
    f.puts '<ul>'

    clean_data['photos'][0..14].each do |hash_info|
        f.puts "<li><img src='#{hash_info['img_src']}' alt='#{hash_info[' ']}'</li>"
      end
    f.puts '</ul>'
    f.puts footer
end
`firefox nasa.html`
   









