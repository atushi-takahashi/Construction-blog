class User::RelationshipsController < ApplicationController
  # フォローする
  def follow
    current_user.follow(params[:id])
    @user = User.find(params[:id])
    @user.create_notification_follow!(current_user)
    redirect_back(fallback_location: root_path)
  end

  # アンフォローする
  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end
end
