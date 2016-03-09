require 'rubygems'
require 'nokogiri'
require 'restclient'

page = Nokogiri::HTML(RestClient.get("https://www.reddit.com/r/EarthPorn/top/"))

top_img_url = page.xpath("//*[@id='siteTable']/div[1]/div[2]/p[1]/a")[0]['href']

time = Time.now.to_s.split(' ', 2).first

path = File.expand_path(File.dirname(File.dirname(__FILE__)))

system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/null.jpg")

system("wget #{top_img_url} -O #{path}/wallpapers/#{time}.jpg")

system("gsettings set org.gnome.desktop.background picture-uri file://#{path}/wallpapers/#{time}.jpg")
