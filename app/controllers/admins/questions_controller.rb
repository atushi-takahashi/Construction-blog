class Admins::QuestionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_question, only: [:show, :update]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question_comments = @question.comments.order(created_at: :desc)
  end

  def update
    @question.update(question_params)
    if @question.delete_flag == true
      flash[:notice] = "記事を非表示にしました"
      redirect_back(fallback_location: root_path)
    elsif @question.delete_flag == false
      flash[:notice] = "記事を表示しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:delete_flag)
  end
end
