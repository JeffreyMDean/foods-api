class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :description
      t.string :cuisine

      t.timestamps
    end
  end
end
