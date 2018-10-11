class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.float :commission
      t.integer :manager_id

      t.timestamps
    end
  end
end
