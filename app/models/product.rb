class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_rich_text :description

  belongs_to :user, optional: true

  validates :name, :product_type, :price, presence: true
  validates :price,length: { maximum: 7 }

  PRODUCT_TYPES = %w{ Sandwich Panini Wrap }
end
