class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  def post_create
    @post = Post.find(params[:post_id])
    @post_comment = @post.comments.build(comment_params)
    @post_comment.user_id = current_user.id
    if @post_comment.save
      # 通知の作成
      @comment_post = @post_comment.post
      @comment_post.post_create_notification_comment!(current_user, @post_comment.id)
      render :post_index
    end
  end

  def post_destroy
    @post_comment = Comment.find(params[:id])
    @post_comment.destroy
    render :post_index
  end

  def question_create
    @question = Question.find(params[:question_id])
    @question_comment = @question.comments.build(comment_params)
    @question_comment.user_id = current_user.id
    if @question_comment.save
      # 通知の作成
      @comment_question = @question_comment.question
      @comment_question.question_create_notification_comment!(current_user, @question_comment.id)
      render :question_index
    end
  end

  def question_destroy
    @question_comment = Comment.find(params[:id])
    @question_comment.destroy
    render :question_index
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :post_id, :question_id, :user_id)
  end
end
