class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true

  attachment :image, destroy: false
end
