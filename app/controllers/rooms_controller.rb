class RoomsController < ApplicationController
  def create
    room = Room.create
    @current_user_room = UserRoom.create(user_id: current_user.id, room_id: room.id)
    @another_user_room = UserRoom.create(user_id: params[:user_id], room_id: room.id)
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
    @message = DirectMessage.new
    @another_user_room = @room.user_rooms.find_by('room_id != ?', current_user.id)
  end
end
