class Api::SongsController < ApplicationController
  # GET /songs
  def index
    @songs = Song.all

    render json: @songs
  end
end
