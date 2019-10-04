class CreateCart < ActiveRecord::Migration[6.0]
  def change
    change_table :orders do |t|
      t.string :line_items, array: true, default: []
      t.bigint :order_subtotal
      t.bigint :order_shipping
      t.bigint :order_tax
      t.bigint :order_total
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address_line_1
      t.string :shipping_address_line_2
      t.string :shipping_country
      t.string :shipping_city
      t.integer :shipping_zip_code
      t.string :shipping_phone_number
      t.string :shipping_email_address
      t.string :shipping_option
      t.string :billing_first_name
      t.string :billing_last_name
      t.string :billing_address_line_1
      t.string :billing_address_line_2
      t.string :billing_country
      t.string :billing_city
      t.integer :billing_zip_code
      t.string :billing_phone_number
      t.string :billing_email_address
    end

    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.string :line_items, array: true, default: []
      t.bigint :cart_subtotal
    end

    create_table :checkouts do |t|
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.string :line_items, array: true, default: []
    end
  end
end
