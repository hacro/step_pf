require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get follows_followings_url
    assert_response :success
  end

  test "should get followers" do
    get follows_followers_url
    assert_response :success
  end
end
