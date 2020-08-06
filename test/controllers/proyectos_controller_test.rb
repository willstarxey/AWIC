require 'test_helper'

class ProyectosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get proyectos_index_url
    assert_response :success
  end

  test "should get create" do
    get proyectos_create_url
    assert_response :success
  end

  test "should get search" do
    get proyectos_search_url
    assert_response :success
  end

  test "should get update" do
    get proyectos_update_url
    assert_response :success
  end

end
