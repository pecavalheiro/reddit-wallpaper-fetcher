#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'json'
require 'open-uri'

def good_resolution?(img)
  img['width'] > 1600 && img['width'] > img['height']
end

begin
  url = 'https://www.reddit.com/r/EarthPorn/top.json?limit=10'
  json_results = RestClient.get(url)
  results = JSON.parse(json_results)
rescue StandardError
  retry
end

top_img = results['data']['children'].detect do |i|
  good_resolution?(i['data']['preview']['images'][0]['source'])
end

img_url = top_img['data']['preview']['images'][0]['source']['url']
time = Time.now.to_s.split(' ', 2).first

path = File.expand_path(File.dirname(File.dirname(__FILE__)))

OS = RUBY_PLATFORM
if OS.include? 'darwin'
  path = "#{Dir.pwd}/wallpapers/#{time}.jpg"
  open(path, 'wb') do |file|
    file << open(img_url).read
  end
  set_wallpaper = "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{path}\"'"
  system(set_wallpaper)
else
  system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/null.jpg")
  system("wget #{img_url} -O #{path}/wallpapers/#{time}.jpg")
  system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/#{time}.jpg")
end
