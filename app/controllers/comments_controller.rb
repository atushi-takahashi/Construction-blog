class CommentsController < ApplicationController
  
  def post_create
    @post = Post.find(params[:post_id])
    @post_comment = @post.comments.build(comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.save
    render :post_index
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
    @question_comment.save
    render :question_index
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
