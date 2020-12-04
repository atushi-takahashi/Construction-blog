class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    root_path
  end

  def timeline_all
    posts = Post.all.order(created_at: :desc)
    questions = Question.all.order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
  end
  
  def search_method
    q = params[:q]
    @posts = Post.search(body_or_title_cont: q).result
    @questions = Question.search(body_or_title_cont: q).result
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:emai])
  end
end
