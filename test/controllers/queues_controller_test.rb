require 'test_helper'

class QueuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @queue = queues(:one)
  end

  test "should get index" do
    get queues_url, as: :json
    assert_response :success
  end

  test "should create queue" do
    assert_difference('Queue.count') do
      post queues_url, params: { queue: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show queue" do
    get queue_url(@queue), as: :json
    assert_response :success
  end

  test "should update queue" do
    patch queue_url(@queue), params: { queue: {  } }, as: :json
    assert_response 200
  end

  test "should destroy queue" do
    assert_difference('Queue.count', -1) do
      delete queue_url(@queue), as: :json
    end

    assert_response 204
  end
end
