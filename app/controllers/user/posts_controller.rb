class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post_comment = Comment.new
    @post_comments = @post.comments.order(created_at: :desc)
  end

  def edit
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
      redirect_to posts_path(@post), notice: '投稿に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'posts/new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '更新に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'posts/edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: '削除に成功しました'
    else
      redirect_to posts_path, alert: '削除できませんでした'
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
