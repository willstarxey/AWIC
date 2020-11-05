require 'test_helper'

class Implementacion::CriteriosCalidadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get implementacion_criterios_calidad_index_url
    assert_response :success
  end

  test "should get create" do
    get implementacion_criterios_calidad_create_url
    assert_response :success
  end

  test "should get update" do
    get implementacion_criterios_calidad_update_url
    assert_response :success
  end

  test "should get delete" do
    get implementacion_criterios_calidad_delete_url
    assert_response :success
  end

end
