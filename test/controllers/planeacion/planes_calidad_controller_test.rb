require 'test_helper'

class Planeacion::PlanesCalidadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get planeacion_planes_calidad_index_url
    assert_response :success
  end

  test "should get create" do
    get planeacion_planes_calidad_create_url
    assert_response :success
  end

  test "should get update" do
    get planeacion_planes_calidad_update_url
    assert_response :success
  end

  test "should get delete" do
    get planeacion_planes_calidad_delete_url
    assert_response :success
  end

end
