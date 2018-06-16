class Api::SongsController < ApplicationController
  # GET /songs
  def index
    @songs = Song.all

    render json: SongSerializer.new(@songs).serialized_json, status: 200
  end
end
