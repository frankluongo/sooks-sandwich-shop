class Cart < ApplicationRecord
  belongs_to :user
  # store :line_items, accessors: [ :products, :quantity ], coder: JSON
end
