class AddStateToBilling < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :billing_state, :string
  end
end
