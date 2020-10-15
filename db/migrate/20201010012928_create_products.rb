class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.float :price
      t.boolean :active, default: true
      t.boolean :is_deleted, default: false
      t.timestamps
    end
  end
end
