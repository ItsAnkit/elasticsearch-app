class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.date :dob
      t.string :address
      t.string :department

      t.timestamps
    end
  end
end
