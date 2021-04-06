class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :books, dependent: :destroy
  attachment :profile_image
  
  validates :name, numericality: { in: 2..20 }, presence: true
  validates :introduction, numericality: { in: 0..50 }, presence: true
end
