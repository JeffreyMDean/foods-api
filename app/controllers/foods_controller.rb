class FoodsController < ApplicationController
  def index
    @foods = Food.all 
    render :index
  end
end 
