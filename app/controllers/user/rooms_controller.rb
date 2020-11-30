class User::RoomsController < ApplicationController
  def create
    room = Room.create
    @current_user_room = UserRoom.create(user_id: current_user.id, room_id: room.id)
    @another_user_room = UserRoom.create((user_room_params).merge(room_id: room.id))
    redirect_to room_path(room)
  end

  def index
    current_user_rooms = current_user.user_rooms
    my_room_ids = []
    current_user_rooms.each do |user_room|
      my_room_ids << user_room.room.id
    end
    @another_user_rooms = UserRoom.where(room_id: my_room_ids).where.not(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id,room_id: @room.id).present?
      @direct_messages = @room.direct_messages
      @direct_message = DirectMessage.new
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  def user_room_params
    params.require(:user_room).permit(:user_id, :room_id)
  end
end
