class User::HomesController < ApplicationController
  before_action :timeline_all, only: [:index]
  before_action :category_all, only: [:index, :search, :ranking_index, :solution_index]
  def index
  end

  def about
    posts = Post.where(delete_flag: false).order(created_at: :desc)
    questions = Question.where(delete_flag: false).order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
  end

  def search
    q = params[:q]
    @posts = Post.search(body_or_title_cont: q).result
    @questions = Question.search(body_or_title_cont: q).result
    @timeline = @posts | @questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
  end

  def ranking_index
    posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    questions = Question.find(Like.group(:question_id).order('count(question_id) desc').pluck(:question_id))
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.likes.count <=> a.likes.count }
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
    end
  end

  def solution_index
    @timeline = Question.where(solution_flag: false).order(created_at: :desc)
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
    end
  end

  private

  def category_all
    @categories = Category.all
  end
end
