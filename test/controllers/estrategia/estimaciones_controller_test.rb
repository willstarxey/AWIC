require 'test_helper'

class Estrategia::EstimacionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estrategia_estimaciones_index_url
    assert_response :success
  end

  test "should get create" do
    get estrategia_estimaciones_create_url
    assert_response :success
  end

  test "should get update" do
    get estrategia_estimaciones_update_url
    assert_response :success
  end

  test "should get delete" do
    get estrategia_estimaciones_delete_url
    assert_response :success
  end

end
