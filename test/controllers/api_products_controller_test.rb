require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get api_products_url

    body = JSON.parse(response.body)
    assert_equal(@product.id, body.last["id"])

    assert_response :success
  end

  test "should show product" do
    get api_product_url(@product)

    body = JSON.parse(response.body)
    assert_equal(@product.id, body["id"])

    assert_response :success
  end
end
