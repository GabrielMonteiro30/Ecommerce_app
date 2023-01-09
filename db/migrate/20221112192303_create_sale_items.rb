class CreateSaleItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_items do |t|
      t.references :product, foreign_key: true
      t.references :sale, foreign_key: true

      t.timestamps
    end
  end
end