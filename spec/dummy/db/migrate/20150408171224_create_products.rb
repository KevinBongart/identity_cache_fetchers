class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :handle
      t.string :product_type
      t.string :vendor

      t.timestamps null: false
    end
  end
end
