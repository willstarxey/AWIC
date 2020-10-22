require 'test_helper'

class Lanzamiento::PersonalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lanzamiento_personal_index_url
    assert_response :success
  end

  test "should get add" do
    get lanzamiento_personal_add_url
    assert_response :success
  end

  test "should get delete" do
    get lanzamiento_personal_delete_url
    assert_response :success
  end

end
