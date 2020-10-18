require 'test_helper'

class Lanzamiento::MetasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lanzamiento_metas_index_url
    assert_response :success
  end

  test "should get create" do
    get lanzamiento_metas_create_url
    assert_response :success
  end

  test "should get update" do
    get lanzamiento_metas_update_url
    assert_response :success
  end

  test "should get delete" do
    get lanzamiento_metas_delete_url
    assert_response :success
  end

end
