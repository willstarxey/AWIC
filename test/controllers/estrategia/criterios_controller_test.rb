require 'test_helper'

class Estrategia::CriteriosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estrategia_criterios_index_url
    assert_response :success
  end

  test "should get create" do
    get estrategia_criterios_create_url
    assert_response :success
  end

  test "should get update" do
    get estrategia_criterios_update_url
    assert_response :success
  end

  test "should get delete" do
    get estrategia_criterios_delete_url
    assert_response :success
  end

end
