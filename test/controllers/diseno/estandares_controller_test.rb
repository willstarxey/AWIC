require 'test_helper'

class Diseno::EstandaresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diseno_estandares_index_url
    assert_response :success
  end

  test "should get create" do
    get diseno_estandares_create_url
    assert_response :success
  end

  test "should get update" do
    get diseno_estandares_update_url
    assert_response :success
  end

  test "should get delete" do
    get diseno_estandares_delete_url
    assert_response :success
  end

end
