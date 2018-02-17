require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, title: @product.title, website_url: @product.website_url } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)

    assert_equal(@product, assigns(:product))
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    new_product = products(:two)
    patch product_url(@product), params: { product: { description: new_product.description } }

    assert_equal(new_product.description, assigns(:product).description)
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should allow subscription/unsubscribing to product" do
    @user = User.create(email: 'test@new.com', password: '123456a', password_confirmation: '123456a', first_name: 'joe', last_name: 'bob')
    sign_in @user
    put subscribe_product_url(@product)

    @product.reload
    assert_equal(1, @product.subscriber_count)
    assert_response :redirect

    delete unsubscribe_product_url(@product)
    @product.reload
    assert_equal(0, @product.subscriber_count)
    assert_response :redirect
  end

end
