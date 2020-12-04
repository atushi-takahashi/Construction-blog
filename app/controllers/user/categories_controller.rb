class User::CategoriesController < ApplicationController
  before_action :search_method, only: [:show]
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    posts = Post.where(category_id: @category).order(created_at: :desc)
    questions = Question.where(category_id: @category).order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
  end
end
