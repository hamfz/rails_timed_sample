require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  setup do
    @product = products(:one)
    @product_two = products(:two)
    @user = users(:one)
    @user_two = users(:two)
  end

  test "should allow users to subscribe" do
    @product.subscribe(@user)
    @product.reload
    assert_equal(1, @product.subscriber_count)
  end

  test "should allow users to unsubscribe" do
    @product.unsubscribe(@user)
    @product.reload
    assert_equal(0, @product.subscriber_count)
  end

  test "should parse and create tags" do
    @product.tag_list = "ham, deli, meat"
    assert_equal(3, @product.tags.count)
    assert_equal('ham, deli, meat', @product.tag_list)
  end

  test "should filter by search" do
    assert_equal(Product.contains_search('alternate').count, 1)
  end

  test "should filter by user" do
    @product.subscribe(@user)
    assert_equal(Product.by_user(@user).count, 1)
  end

  test "should filter by tag" do
    @product.tag_list = "ham, deli, meat"
    assert_equal(Product.by_tag('ham').count, 1)
  end

end
