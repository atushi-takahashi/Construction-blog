class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def edit
  end

  def update
  end

  private

  def find_user
    @user = User.find(patams[:id])
  end
end
