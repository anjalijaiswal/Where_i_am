require 'test_helper'

class ChatControllerTest < ActionController::TestCase
  test "should get chatting" do
    get :chatting
    assert_response :success
  end

end
