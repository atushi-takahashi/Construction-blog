class User::HomesController < ApplicationController
  before_action :timeline_all, only: [:top]
  before_action :category_all, only: [:top, :search, :ranking_index, :solution_index]
  def top
  end

  def about
  end

  def search
    q = params[:q]
    @posts = Post.search(body_or_title_cont: q).result
    @questions = Question.search(body_or_title_cont: q).result
    @timeline = @posts | @questions
    @timeline.sort! { |a,b| b.created_at <=> a.created_at }
  end

  def ranking_index
    posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    questions = Question.find(Like.group(:question_id).order('count(question_id) desc').pluck(:question_id))
    @timeline = posts | questions
    @timeline.sort! { |a,b| b.likes.count <=> a.likes.count }
  end
  
  def solution_index
    @timeline = Question.where(solution_flag: false).order(created_at: :desc)
  end
  
  private
  
  def category_all
    @categories = Category.all
  end

end
