class Api::QueuesController < ApplicationController
  # GET /queues
  def index
    data = []

    REDIS.keys.each do |key|
      response = REDIS.get(key)
      json_response = JSON.parse(response)

      data << json_response
    end

    render json: data, status: 200
  end

  # {"id"=>"1", "name"=>"shikugawa", "controller"=>"api/queues", "action"=>"create"}
  # POST /queues
  def create
    @song = Song.find(params[:id])

    begin
      data = {
        "id": params[:id],
        "song": {
          "song_name": @song.song_name,
          "artist_name": @song.artist_name,
          "artwork_url": @song.artwork_url,
          "time": @song.time,
          "music_url": @song.music_url
        },
        "url": @song.music_url,
        "name": params[:name]
      }.to_json

      REDIS.set(Time.now.to_s, data)
    rescue Exception => e
      render json: { "result": "failed", "message": e.message }, status: 400 and return
    end

    render json: { "result": "succeeded" }, status: 200
  end

  def playing
    begin
      playing_music_key = REDIS.keys.last
      playing_music_data = REDIS.get(playing_music_key)
    rescue Exception => e
      data = {
        "message": e.message
      }

      render json: data, status: 200 and return
    end

    render json: playing_music_data, status: 200
  end

  private
    # Only allow a trusted parameter "white list" throug
    def queue_params
      params.require(:queue).permit(:id, :name)
    end
end
