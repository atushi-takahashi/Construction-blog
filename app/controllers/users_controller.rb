class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    posts = Post.where(user_id: @user.id).order(created_at: :desc)
    questions = Question.where(user_id: @user.id).order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
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

  private

  def user_params
    params.require(:user).permit(:name, :image, :occupation, :work_history, :profile)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
