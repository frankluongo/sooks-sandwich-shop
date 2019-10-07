class UpdateLineItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :cart_line_items, :products_id
    remove_column :cart_line_items, :carts_id
    remove_column :order_line_items, :product_id


    change_table :cart_line_items do |t|
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
    end

    change_table :order_line_items do |t|
      t.integer :product, foreign_key: true
    end
  end
end
