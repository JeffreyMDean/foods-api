require "test_helper"

class FoodsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/foods.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Food.count, data.length
  end

  test "create" do    # expecting the count of Food to increase by 1 during the block's execution. The assert_difference method will ensure that after the block of code inside it runs, the Food.count value increases by 1, indicating a new record was created
    assert_difference "Food.count", 1 do
      post "/foods.json", params: { name: "smore", description: "fireside treat", cuisine: "American" }
      assert_response 200
    end
  end
end 
