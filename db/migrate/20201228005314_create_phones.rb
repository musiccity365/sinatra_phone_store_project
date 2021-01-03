class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :name
      t.string :model
      t.string :color
      t.integer :age
      t.integer :user_id
    end
  end
end
