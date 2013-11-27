require 'test_helper'

class UsageChartControllerTest < ActionController::TestCase
  test "should get chart" do
    get :chart
    assert_response :success
  end

end
