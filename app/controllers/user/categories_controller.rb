class User::CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    posts = Post.where(category_id: @category).order(created_at: :desc)
    questions = Question.where(category_id: @category).order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end
end
