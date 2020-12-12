class User::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:post_report_create, :post_report_new]
  before_action :find_question, only: [:question_report_create, :question_report_new]

  def post_report_new
    @report = Report.new
  end

  def post_report_create
    report = @post.reports.build(report_params)
    report.user_id = current_user.id
    if report.save
      Notification.create(visiter_id: report.user_id, visited_id: @post.user.id, report_id: report.id, post_id: @post.id, admin_id: 1, action: "post_report")
      redirect_to post_path(@post), notice: '通報しました'
    else
      flash[:alert] = "入力に不備があります"
      redirect_to post_report_new_path(@post)
    end
  end

  def question_report_new
    @report = Report.new
  end

  def question_report_create
    report = @question.reports.build(report_params)
    report.user_id = current_user.id
    if report.save
      Notification.create(visiter_id: report.user_id, visited_id: @question.user.id, report_id: report.id, question_id: @question.id, admin_id: 1, action: "question_report")
      redirect_to question_path(@question), notice: '通報しました'
    else
      flash[:alert] = "入力に不備があります"
      redirect_to question_report_new_path(@question)
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def report_params
    params.require(:report).permit(:message, :post_id, :question_id, :user_id, :category)
  end
end
