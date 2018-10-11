class CreateManagerEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :manager_employees do |t|
      t.integer :user_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
