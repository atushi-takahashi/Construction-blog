class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 1, maximum: 20 }, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :questions, dependent: :destroy
end
