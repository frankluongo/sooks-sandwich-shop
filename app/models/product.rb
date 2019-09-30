class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_rich_text :description

  has_many :orders
  has_many :users, through: :orders

  validates :name, :product_type, :price, presence: true
  validates :price,length: { maximum: 7 }

  PRODUCT_TYPES = %w{ Sandwich Panini Wrap }

  def to_param
    slug
  end

  def self.slugify(title)
    # title.downcase.gsub(/[^0-9A-Za-z]/, '')
    title.downcase.gsub(/[^a-zA-Z. ]/, '').gsub(" ", "-");
  end
end
