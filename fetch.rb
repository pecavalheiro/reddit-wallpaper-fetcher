require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'json'
require 'pp'

def good_resolution?(img)
  img['width'] > 1600 && img['width'] > img['height']
end

begin
  results = JSON.parse(RestClient.get('https://www.reddit.com/r/EarthPorn/top.json?limit=10'))
rescue
  retry
end

top_img = results['data']['children'].detect { |i| good_resolution?(i['data']['preview']['images'][0]['source']) }

img_url = top_img['data']['preview']['images'][0]['source']['url']

time = Time.now.to_s.split(' ', 2).first

path = File.expand_path(File.dirname(File.dirname(__FILE__)))

system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/null.jpg")
system("wget #{img_url} -O #{path}/wallpapers/#{time}.jpg")
system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/#{time}.jpg")
