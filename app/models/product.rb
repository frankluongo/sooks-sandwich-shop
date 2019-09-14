class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user, optional: true

  validates :name, :product_type, :price, presence: true
  validates :price, numericality: { only_integer: true}, length: { maximum: 7}

  PRODUCT_TYPES = %w{ Sandwich Panini Wrap }
end
