# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
[
  { 'id': 1, 'url': 'http://amachamusic.chagasi.com/mp3/technophobia.mp3' },
  { 'id': 2, 'url': 'http://amachamusic.chagasi.com/mp3/rokugatsunoamagasa.mp3' }
].each do |data|
  Song.create(id: data[:id], url: data[:url])
end
