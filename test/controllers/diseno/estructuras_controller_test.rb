require 'test_helper'

class Diseno::EstructurasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diseno_estructuras_index_url
    assert_response :success
  end

  test "should get create" do
    get diseno_estructuras_create_url
    assert_response :success
  end

  test "should get update" do
    get diseno_estructuras_update_url
    assert_response :success
  end

  test "should get delete" do
    get diseno_estructuras_delete_url
    assert_response :success
  end

end
