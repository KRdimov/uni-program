require 'test_helper'

class ProgramControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get program_index_url
    assert_response :success
  end

end
