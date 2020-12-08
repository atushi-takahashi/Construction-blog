# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  
  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.work_history = "4年"
      user.profile = "神奈川県の地場ゼネコンで土木の施工管理をしています。
                      最近は仕事にも慣れてきてできる仕事の幅も広がったの
                      ですが、その分わからないことも増えてきたので質問、
                      また共有させていただきたいと思いこのサイトに登録しました。"
      user.occupation = "土木施工管理"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
