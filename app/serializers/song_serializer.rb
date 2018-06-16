class SongSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :song_name, :artist_name, :artwork_url, :time, :music_url
end
