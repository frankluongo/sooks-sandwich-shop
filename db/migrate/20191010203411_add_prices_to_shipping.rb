class AddPricesToShipping < ActiveRecord::Migration[6.0]
  def change
    change_table :shipping_options do |t|
      t.decimal :price, precision: 30, scale: 10
    end
  end
end
