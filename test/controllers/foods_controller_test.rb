require "test_helper"

class FoodsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/foods.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Food.count, data.length
  end
end
