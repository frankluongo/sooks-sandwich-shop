class CreateShippingOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_options do |t|
      t.string :name
    end
  end
end
