class Api::QueuesController < ApplicationController
  # GET /queues
  def index
    data = { "info": [] }
    
    REDIS.keys.each do |key|
      data[:info] << REDIS.get(key)
    end

    render json: data, status: 200
  end

  # {"id"=>"1", "url"=>"http://amachamusic.chagasi.com/mp3/technophobia.mp3", "name"=>"shikugawa", "controller"=>"api/queues", "action"=>"create"}
  # POST /queues
  def create
    begin
      data = {
        "id": params[:id],
        "url": params[:url],
        "name": params[:name]
      }.to_s

      REDIS.set(Time.now.to_s, data)
    rescue
      render json: { "result": "failed" }, status: 400
    end

    render json: { "result": "succeeded" }, status: 200
  end

  private
    # Only allow a trusted parameter "white list" throug
    def queue_params
      params.require(:queue).permit(:id, :url, :name)
    end
end
