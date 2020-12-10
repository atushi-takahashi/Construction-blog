class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :direct_messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
