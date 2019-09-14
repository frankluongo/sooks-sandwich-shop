class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string   :name, default: ""
      t.string   :product_type, default: ""
      t.text     :description, default: ""
      t.json     :image, default: ""
      t.integer  :user_id, default: 0
      t.decimal  :price, default: 0, precision: 5, scale: 2

      t.timestamps
    end
  end
end
