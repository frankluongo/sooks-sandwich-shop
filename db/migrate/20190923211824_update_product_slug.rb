class UpdateProductSlug < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :slug, :string, null: false
    add_index :products, :slug, unique: true
  end
end
