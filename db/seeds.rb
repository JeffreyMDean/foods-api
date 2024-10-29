# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
food1 = Food.new(name: "pancakes", description: "yummy treat", cuisine: "American")
food1.save

food2 = Food.new(name: "burritos", description: "tortilla with food inside", cuisine: "Mexican")
food2.save

food3 = Food.new(name: "spaghetti and meatballs", description: "noodles, meat, and sauce", cuisine: "Italian")
food3.save 