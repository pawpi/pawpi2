class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :type_id
      t.integer :user_id
      t.string :breed
      t.integer :zipcode
      t.integer :age
      t.string :sex
      t.string :description
      t.integer :is_reported, limit: 1

      t.timestamps null: false
    end
  end
end
