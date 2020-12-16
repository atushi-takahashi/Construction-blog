class User::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post_comment = Comment.new
    @post_comments = @post.comments.order(created_at: :desc)
  end

  def edit
    unless @post.user.id == current_user.id
      flash[:alert] = '他人の記事は編集できません'
      redirect_to root_path
    end
    @categories = Category.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '投稿に成功しました'
      redirect_to post_path(@post)
    else
      flash[:alert] = "入力に不備があります"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = '更新に成功しました'
      redirect_to post_path(@post)
    else
      flash[:alert] = "入力に不備があります"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = '削除に成功しました'
      redirect_to homes_index_path
    else
      flash[:alert] = "削除できませんでした"
      redirect_to homes_index_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body, :category_id, :status)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
