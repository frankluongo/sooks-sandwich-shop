class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :line_items
    remove_column :carts, :line_items

    create_table :cart_line_items do |t|
      t.references :products, foreign_key: true
      t.references :carts, foreign_key: true
      t.integer :quantity
    end

    create_table :order_line_items do |t|
      t.integer :product_id
      t.references :order, foreign_key: true
      t.integer :quantity
    end
  end
end
