class Admins::HomesController < ApplicationController
  def top
    @reports = Report.where(processing_flag: false)
  end
end
