class Admins::ReportsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @reports = Report.all.order(created_at: :desc)
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.processing_flag == false
      @report.update(processing_flag: true)
      flash[:notice] = "通報を処理済にしました"
      redirect_back(fallback_location: root_path)
    elsif @report.processing_flag == true
      @report.update(processing_flag: false)
      flash[:notice] = "通報を未処理にしました"
      redirect_back(fallback_location: root_path)
    end
  end

  def delete_flag_update
    @report = Report.find(params[:id])
    # @report.update
    if @report.question_id.nil?
      if @report.post.delete_flag == false
        @report.post.update(delete_flag: true)
        flash[:notice] = "記事を非表示にしました"
        redirect_back(fallback_location: root_path)
      elsif @report.post.delete_flag == true
        @report.post.update(delete_flag: false)
        flash[:notice] = "記事を表示しました"
        redirect_back(fallback_location: root_path)
      end
    elsif @report.post_id.nil?
      if @report.question.delete_flag == false
        @report.question.update(delete_flag: true)
        flash[:notice] = "記事を非表示にしました"
        redirect_back(fallback_location: root_path)
      elsif @report.question.delete_flag == true
        @report.question.update(delete_flag: false)
        flash[:notice] = "記事を表示しました"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    @report.destroy
    flash[:notice] = "通報を削除しました"
    redirect_back(fallback_location: root_path)
  end
end
