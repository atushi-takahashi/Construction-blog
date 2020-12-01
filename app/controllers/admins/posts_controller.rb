class Admins::PostsController < ApplicationController
  before_action :find_post, only: [:show, :update]
  def index
  end

  def show
  end
  
  def update
    @post.update(post_params)
    if @post.delete_flag == true
      flash[:notice] = "記事を非表示にしました"
      redirect_back(fallback_location: root_path)
    elsif @post.delete_flag == false
      flash[:notice] = "記事を表示しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  def find_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.permit(:delete_flag)
  end
end
