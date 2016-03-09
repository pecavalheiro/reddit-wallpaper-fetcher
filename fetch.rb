require 'rubygems'
require 'nokogiri'
require 'restclient'

page = Nokogiri::HTML(RestClient.get("https://www.reddit.com/r/EarthPorn/top/"))

top_img_url = page.xpath("//*[@id='siteTable']/div[1]/div[2]/p[1]/a")[0]['href']

time = Time.now.to_s.split(' ', 2).first

system("mkdir -p ~/wallpapers")

system("gsettings set org.gnome.desktop.background picture-uri file:///home/pedro/wallpapers/null.jpg")

system("wget #{top_img_url} -O ~/wallpapers/#{time}.jpg")

system("gsettings set org.gnome.desktop.background picture-uri file:///home/pedro/wallpapers/#{time}.jpg")
