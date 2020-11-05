require 'test_helper'

class Pruebas::PruebasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pruebas_pruebas_index_url
    assert_response :success
  end

  test "should get create" do
    get pruebas_pruebas_create_url
    assert_response :success
  end

  test "should get update" do
    get pruebas_pruebas_update_url
    assert_response :success
  end

  test "should get delete" do
    get pruebas_pruebas_delete_url
    assert_response :success
  end

end
