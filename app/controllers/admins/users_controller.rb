class Admins::UsersController < ApplicationController
  before_action :find_user, only: [:show, :update]
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    # 投稿及び質問を更新順に表示
    posts = Post.where(user_id: @user.id).order(created_at: :desc)
    questions = Question.where(user_id: @user.id).order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
  end

  def update
    @user.update(user_params)
    if @user.withdrawal_status == true
      flash[:notice] = "アカウントを凍結させました"
      redirect_back(fallback_location: root_path)
    elsif @user.withdrawal_status == false
      flash[:notice] = "アカウントの凍結を"
      redirect_back(fallback_location: root_path)
    else
      render 'admins/users/edit'
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:withdrawal_status)
  end
end
