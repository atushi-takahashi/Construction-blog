class User::NotificationsController < ApplicationController
  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = Notification.where(visiter_id: current_user.id, admin_id: nil)
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    #通知を全削除
      @notifications = Notification.where(visiter_id: current_user.id, admin_id: nil).destroy_all
      redirect_to notifications_path
  end
end
