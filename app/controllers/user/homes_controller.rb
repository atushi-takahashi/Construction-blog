class User::HomesController < ApplicationController
  before_action :timeline_all, only: [:top]
  before_action :search_method, only: [:top, :search]
  def top
    @categories = Category.all
  end

  def about
  end

  def search
    @categories = Category.all
    @timeline = @posts | @questions
    @timeline.sort! { |a,b| b.created_at <=> a.created_at }
  end

  def ranking_index
    @categories = Category.all
    posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    questions = Question.find(Like.group(:question_id).order('count(question_id) desc').pluck(:question_id))
    @timeline = posts | questions
    @timeline.sort! { |a,b| b.likes.count<=> a.likes.count }
  end

end
