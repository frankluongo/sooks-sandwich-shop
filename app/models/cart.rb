class Cart < ApplicationRecord
  belongs_to :user
  has_one :cart, dependent: :destroy
end
