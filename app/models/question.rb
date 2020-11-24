class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  attachment :image, destroy: false
end
