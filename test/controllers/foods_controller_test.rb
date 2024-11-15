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
          # if the keys in the response do not match this list, the test will fail
# This test ensures that when you request a food item via the show action (e.g., /foods/1.json), the controller responds with the correct HTTP status (200 OK), and the response contains the expected keys. If either the status or the keys in the JSON response are wrong, the test will fail, helping you verify the correctness of your controller's behavior.

  test "update" do
    food = Food.first
    patch "/foods/#{food.id}.json", params: { name: "Updated name", description: "Updated description", cuisine: "Updated cuisine" }
    assert_response 200 

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["name"]
    assert_equal "Updated description", data["description"]
    assert_equal "Updated cuisine", data["cuisine"]
  end
end 

# Food is the model representing foods, and first is an ActiveRecord method that retrieves the first record from the foods table in your database
# /foods/#{food.id}.json is the url I'm sending the request to and this way the server knows which food to update. It uses string interpolation to dynamicaly insert the id of the food recrod that was fetched in the previous line. 
# .json specifies I want to interact with JSON data
# params: { ... } these are the parameters I'm sending in the request body representing the new values I want to update for the food. I'm updsating the name, description, and cuisine of the food to "Updated name" and so on....in a real-world scenario, the values might come from a user submitting a form, but in this case, I am hardocing them for the test
# response.body refers to the body of the http response returned by my server after the patch request is made...it will be in JSON format since I specidfied .json in the URL and should contain the updated data of the food object
# JSON.parse converts the raw JSON response body into a Ruby hash, which makes it easier to work with in the test and the parsed data is then stored in the data variable
# After parsing, data will be a Ruby hash where you can access the updated attributes using the keys (name, description, cuisine)
# After server process the update request, it typically returns a JSON response which contains the updated attributes of the food object: 
# {
#   "id": 1,
#   "name": "Updated name",
#   "description": "Updated description",
#   "cuisine": "Updated cuisine"
# }
# The raw JSON response (from above) is converted into a Ruby hash like so: 
# data = {
#   "id" => 1,
#   "name" => "Updated name",
#   "description" => "Updated description",
#   "cuisine" => "Updated cuisine"
# }
# So, data["name"] is accessing the value of the name key in the hash, which holds the updated value of the name field...data["name"] which holds "Updated name"
# "Updated name" is simply the value you are expecting to be returned in the response. It is the new value you set in your patch request when you wanted to update the name of the food record
# Finally the assertion 'assert_equal "Updated name", data["name"]' is saying: The data hash contains a key called name. I expect the value of this name key to be "Updated name", because that's the new value I set in the update request
# data["name"] retrieves the updated name value from the response, and you're checking if it matches the expected value "Updated name"
# data["name"] refers to the value of the name attribute in the response returned by the server, after the patch request is processed. It should reflect the updated name of the food
# "Updated name" is the value you expect the name field to have after the update. It's the new value you set in the request
# When the test passes, it means that the name attribute of the food was successfully updated in the database, and the server correctly returned the updated value in the response



