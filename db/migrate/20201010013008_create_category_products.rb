class CreateCategoryProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :category_products do |t|
      t.references :category, null: false, index: true
      t.references :product, null: false, index: true
      t.timestamps
    end
  end
end
