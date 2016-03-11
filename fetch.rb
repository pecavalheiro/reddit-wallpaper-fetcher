require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'json'
require 'pp'

json = JSON.parse(RestClient.get("https://www.reddit.com/r/EarthPorn/top.json?limit=1"))

top_img_url = json['data']['children'][0]['data']['preview']['images'][0]['source']['url']

time = Time.now.to_s.split(' ', 2).first

path = File.expand_path(File.dirname(File.dirname(__FILE__)))

system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/null.jpg")

system("wget #{top_img_url} -O #{path}/wallpapers/#{time}.jpg")

system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/#{time}.jpg")
