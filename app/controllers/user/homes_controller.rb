class User::HomesController < ApplicationController
  before_action :timeline_all, only: [:top]
  def top; end

  def about; end
end
