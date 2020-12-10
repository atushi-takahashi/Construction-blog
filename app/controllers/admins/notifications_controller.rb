class Admins::NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(admin_id: 1)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy_all
    #通知を全削除
      notifications = Notification.where(admin_id: 1)
      @notifications = notifications.destroy_all
      redirect_to admins_notifications_path
  end
end
