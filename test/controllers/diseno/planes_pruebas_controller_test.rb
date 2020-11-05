require 'test_helper'

class Diseno::PlanesPruebasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diseno_planes_pruebas_index_url
    assert_response :success
  end

  test "should get create" do
    get diseno_planes_pruebas_create_url
    assert_response :success
  end

  test "should get update" do
    get diseno_planes_pruebas_update_url
    assert_response :success
  end

  test "should get delete" do
    get diseno_planes_pruebas_delete_url
    assert_response :success
  end

end
