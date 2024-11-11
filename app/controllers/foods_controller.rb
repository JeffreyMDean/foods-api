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
end 
