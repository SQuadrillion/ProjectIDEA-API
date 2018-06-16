class SongSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :url
end
