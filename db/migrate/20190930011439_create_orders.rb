class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :products, array: true, default: []
      t.integer :user_id

      t.timestamps
    end
    add_index :orders, [:products, :user_id]
  end
end
