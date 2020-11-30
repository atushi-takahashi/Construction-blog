class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update]
  before_action :find_user_id, only: [:following, :follower]

  def show
    # 投稿及び質問を更新順に表示
    posts = Post.where(user_id: @user.id).order(created_at: :desc)
    questions = Question.where(user_id: @user.id).order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
     # ダイレクトメッセージ
    @current_user_room = UserRoom.where(user_id: current_user.id)
    @another_user_room = UserRoom.where(user_id: @user.id)
    if @user.id != current_user.id
      @current_user_room.each do |cu|
        @another_user_room.each do |u|
          # ルームが存在する時
          if cu.room_id == u.room_id
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      # ルームが存在しない時
      unless @is_room
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'users/edit'
    end
  end

  # 自分がフォローしているユーザー一覧
  def following
    @followings = @user.following_user
  end

  # 自分をフォローしているユーザー一覧
  def follower
    @followers = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :occupation, :work_history, :profile)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def find_user_id
    @user = User.find(params[:user_id])
  end
  
end
