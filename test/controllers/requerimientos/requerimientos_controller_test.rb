require 'test_helper'

class Requerimientos::RequerimientosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get requerimientos_requerimientos_index_url
    assert_response :success
  end

  test "should get create" do
    get requerimientos_requerimientos_create_url
    assert_response :success
  end

  test "should get update" do
    get requerimientos_requerimientos_update_url
    assert_response :success
  end

  test "should get delete" do
    get requerimientos_requerimientos_delete_url
    assert_response :success
  end

end
