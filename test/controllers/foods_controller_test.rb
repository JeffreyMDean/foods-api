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

  test "show" do
    get "/foods/#{Food.first.id}.json"
    assert_response 200
                       # raw resonse body from the server
    data = JSON.parse(response.body)
    assert_equal ["id", "name", "description", "cuisine", "created_at", "updated_at"], data.keys
  end               # list of all keys (attributes) in the response
end           # if the keys in the response do not match this list, the test will fail
# This test ensures that when you request a food item via the show action (e.g., /foods/1.json), the controller responds with the correct HTTP status (200 OK), and the response contains the expected keys. If either the status or the keys in the JSON response are wrong, the test will fail, helping you verify the correctness of your controller's behavior.


