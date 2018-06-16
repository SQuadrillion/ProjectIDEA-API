class Api::SongsController < ApplicationController
  # GET /songs
  def index
    @songs = Song.all

    render json: @songs, status: 200
  end

  # POST /songs
  def new
    info = {
      "song_name": "",
      "artist_name": "",
      "time": 0 # second
    }

    open(params[:song][:music_url]) do |filename|
      Mp3Info.open(filename) do |metadata|
        info[:time] = metadata.length
        info[:song_name] = metadata.tag["title"]
        info[:artist_name] = metadata.tag["artist"]
      end
    end

    [:time, :song_name, :artist_name].each do |symb|
      params[:song][symb] = info[symb]
    end

    @song = Song.new(songs_param)

    if @song.save
      render json: SongSerializer.new(@song).serialized_json, status: 400
    else
      render json: { "status": "failed" }, status: 400
    end
  end

  def destroy
    
  end

  private
  def songs_param
    params.require(:song).permit(:artwork_url, :music_url, :song_name, :artist_name, :time)
  end
end
