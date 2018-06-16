# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

require 'mp3info'
require 'open-uri'

[
  { 'id': 1,
    'url': 'http://amachamusic.chagasi.com/mp3/technophobia.mp3',
    'artwork_url': 'https://pbs.twimg.com/profile_images/581025665727655936/9CnwZZ6j.jpg' },
  { 'id': 2,
    'url': 'http://amachamusic.chagasi.com/mp3/rokugatsunoamagasa.mp3',
    'artwork_url': 'https://pbs.twimg.com/profile_images/581025665727655936/9CnwZZ6j.jpg' }
].each do |data|
  info = {
    "song_name": "",
    "artist_name": "",
    "time": 0 # second
  }

  open(data[:url]) do |filename|
    Mp3Info.open(filename) do |metadata|
      info[:time] = metadata.length
      info[:song_name] = metadata.tag["title"]
      info[:artist_name] = metadata.tag["artist"]
    end
  end

  Song.create(id: data[:id], song_name: info[:song_name], artist_name: info[:artist_name],
     artwork_url: data[:artwork_url], time: info[:time], music_url: data[:url])
end
