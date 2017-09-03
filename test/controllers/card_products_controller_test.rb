require 'test_helper'

class CardProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card_product = card_products(:one)
  end

  test "should get index" do
    get card_products_url
    assert_response :success
  end

  test "should get new" do
    get new_card_product_url
    assert_response :success
  end

  test "should create card_product" do
    assert_difference('CardProduct.count') do
      post card_products_url, params: { card_product: {  } }
    end

    assert_redirected_to card_product_url(CardProduct.last)
  end

  test "should show card_product" do
    get card_product_url(@card_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_product_url(@card_product)
    assert_response :success
  end

  test "should update card_product" do
    patch card_product_url(@card_product), params: { card_product: {  } }
    assert_redirected_to card_product_url(@card_product)
  end

  test "should destroy card_product" do
    assert_difference('CardProduct.count', -1) do
      delete card_product_url(@card_product)
    end

    assert_redirected_to card_products_url
  end
end
