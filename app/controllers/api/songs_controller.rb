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

    open(params[:music_url]) do |filename|
      Mp3Info.open(filename) do |metadata|
        info[:time] = metadata.length

        if metadata.tag["title"].nil?
          title = params[:music_url].split('/')
          info[:song_name] = title[-1].split('.')[0]
        else
          info[:song_name] = metadata.tag["title"]
        end

        info[:artist_name] = metadata.tag["artist"]
      end
    end

    [:time, :song_name, :artist_name].each do |symb|
      params[symb] = info[symb]
    end

    @song = Song.new(songs_param)

    if @song.save
      render json: @song, status: 200
    else
      render json: { "status": "failed" }, status: 400
    end
  end

  def destroy
    @song = Song.find(params[:id])

    begin
      @song.delete()
    rescue Exception => e
      render json: { "status": "failed", "message": e.message }, status: 400 and return
    end

    render json: { "status": "succeeded" }, status: 200
  end

  private
  def songs_param
    params.permit(:artwork_url, :music_url, :song_name, :artist_name, :time)
  end
end
