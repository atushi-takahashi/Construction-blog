class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_homes_path
    when User
      homes_index_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      root_path
    else
      new_admin_session_path
    end
  end

  def timeline_all
    posts = Post.all.order(created_at: :desc)
    questions = Question.all.order(created_at: :desc)
    @timeline = posts | questions
    @timeline.sort! { |a, b| b.created_at <=> a.created_at }
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:emai])
  end
end
