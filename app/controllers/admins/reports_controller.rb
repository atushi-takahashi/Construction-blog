class Admins::ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def destroy
    @report.destroy
    flash[:notice] = "通報を削除しました"
    redirect_back(fallback_location: root_path)
  end

end
