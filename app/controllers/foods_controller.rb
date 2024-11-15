class FoodsController < ApplicationController
  def index
    @foods = Food.all 
    render :index
  end

  def create
    @food = Food.create(
      name: params[:name],
      description: params[:description],
      cuisine: params[:cuisine]
    )
    render :show
  end

  def show
    @food = Food.find_by(id: params[:id])
    render :show
  end 
  # this is a call to the find_by method on the Food Model (which represents the foods in your database). find_by is a Rails ActiveRecord method that retrieves a single record from the database based on a condition (in this case, a condition on the id field).
  # id: params[:id] is the condition we are passing to find_by
  # params[:id] refers to the id parameter that is typically passed in the URL when a user requests a specific resource (like a food item). For example if the URL is /foods/3 then params[:id] would be 3, and Rails would use that to find the food item with the ID of 3 in the database
  # In this case, params[:id] is a hash key-value pair where the key is :id and the value is the actual ID that was sent in the request.
  # In Rails, variables that start with @ are isntance variables and are accesible in the corresponding view to display the food object
  # render :show tells Rails to load and display the view associated with the show action, passing the @food instance variable to that view (so it can be displayed to the user)
  # params [:id] refers to the id that is passed in the URL when the user accesses the show page for a particular food item. The id is used to uniquely identify the food record that should eb retrieved from the database.

  def update
    @food = Food.find_by(id: params[:id])
    @food.update(
      name: params[:name] || @food.name,
      description: params[:description] || @food.description,
      cuisine: params[:cuisine] || @food.cuisine,
    )
    render :show
  end
end 
# if params[:attribute] is nil, the original value @food.attribute will be preserved
# render :show tells the controller to render the show view template. After the update, this is typically used to display the updated food item to the user