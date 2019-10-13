class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_username

  def set_username
    if self.guest
      self.username = "user_#{Time.now.to_i}#{rand(100)}"
    end
  end

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :products, through: :orders
  has_one :cart, dependent: :destroy
end
