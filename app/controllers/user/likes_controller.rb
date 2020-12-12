class User::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :post_set_variables, only: [:post_like, :post_unlike]
  before_action :question_set_variables, only: [:question_like, :question_unlike]

  def post_like
    like = current_user.likes.new(post_id: @post.id)
    like.save
    # 通知の作成
    @post.post_create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def post_unlike
    unlike = current_user.likes.find_by(post_id: @post.id)
    unlike.destroy
  end

  def question_like
    like = current_user.likes.new(question_id: @question.id)
    like.save
    # 通知の作成
    @question.question_create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def question_unlike
    unlike = current_user.likes.find_by(question_id: @question.id)
    unlike.destroy
  end

  private

  def post_set_variables
    @post = Post.find(params[:post_id])
    @post_id_name = "#post_like-link-#{@post.id}"
  end

  def question_set_variables
    @question = Question.find(params[:question_id])
    @question_id_name = "#question_like-link-#{@question.id}"
  end
end
