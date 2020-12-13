class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @reports = Report.where(processing_flag: false)
  end
end
