class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :questions, dependent: :destroy
end
