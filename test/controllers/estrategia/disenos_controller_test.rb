require 'test_helper'

class Estrategia::DisenosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estrategia_disenos_index_url
    assert_response :success
  end

  test "should get create" do
    get estrategia_disenos_create_url
    assert_response :success
  end

  test "should get update" do
    get estrategia_disenos_update_url
    assert_response :success
  end

  test "should get delete" do
    get estrategia_disenos_delete_url
    assert_response :success
  end

end
