class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @question = Question.all
  end

  def show; end

  def edit; end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to questions_path(@question), notice: '投稿に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'new'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path(@question), notice: '更新に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'questions/edit'
    end
  end

  def destroy
    if @question.destroy(question_params)
      redirect_to questions_path, notice: '削除に成功しました'
    else
      redirect_to questions_path, alert: '削除できませんでした'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :image, :user_id, :solution_flag)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
