class AddToOrders < ActiveRecord::Migration[6.0]
  def change
    change_table :orders do |t|
      t.boolean :shipping_details_completed, default: false
      t.boolean :shipping_option_completed, default: false
      t.boolean :billing_details_completed, default: false
      t.boolean :shipping_same_as_billing, default: false
      t.string :billing_option
    end

    create_table :billing_options do |t|
      t.string :name
    end
  end
end
