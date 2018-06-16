class Api::QueuesController < ApplicationController
  # GET /queues
  def index
    @queues = Queue.all

    render json: @queues
  end

  # POST /queues
  def create
    @queue = Queue.new(queue_params)

    if @queue.save
      render json: @queue, status: :created, location: @queue
    else
      render json: @queue.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def queue_params
      params.require(:queue).permit(:id, :url)
    end
end
