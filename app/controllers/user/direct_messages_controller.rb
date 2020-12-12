class User::DirectMessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    message = DirectMessage.new(message_params)
    message.user_id = current_user.id
    if message.save
      room = message.room
      roommembernotme = UserRoom.where(room_id: room.id).where.not(user_id: current_user.id)
      theid = roommembernotme.find_by(room_id: room.id)
      notification = current_user.active_notifications.new(
        room_id: room.id,
        direct_message_id: message.id,
        visited_id: theid.user_id,
        visiter_id: current_user.id,
        action: 'dm'
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
      redirect_to room_path(message.room)
    else
      flash[:alert] = "メッセージを入力してください"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    message = DirectMessage.find(params[:id])
    message.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def message_params
    params.require(:direct_message).permit(:room_id, :message)
  end
end
