class AddStatusToOrder < ActiveRecord::Migration[6.0]
  def change
    change_table :orders do |t|
      t.boolean :order_completed, default: false
    end
  end
end
