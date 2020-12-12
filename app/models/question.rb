class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  attachment :image, destroy: false

  def question_create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      question_id: id,
      visited_id: user_id,
      action: "question_like"
    )
    notification.save if notification.valid?
  end

  def question_create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(question_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      question_save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    question_save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def question_save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      question_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'question_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
