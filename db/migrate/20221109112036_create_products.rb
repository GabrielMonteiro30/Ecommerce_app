class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.column :price, "double"

      t.timestamps
    end
  end
end
