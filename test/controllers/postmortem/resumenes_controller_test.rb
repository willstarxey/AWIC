require 'test_helper'

class Postmortem::ResumenesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get postmortem_resumenes_index_url
    assert_response :success
  end

  test "should get create" do
    get postmortem_resumenes_create_url
    assert_response :success
  end

  test "should get update" do
    get postmortem_resumenes_update_url
    assert_response :success
  end

  test "should get delete" do
    get postmortem_resumenes_delete_url
    assert_response :success
  end

end
