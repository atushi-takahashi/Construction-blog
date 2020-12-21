require 'rails_helper'

RSpec.describe User::ReportsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @category = FactoryBot.create(:category)
    @post = FactoryBot.create(:post)
    @question = FactoryBot.create(:question)
  end
  describe 'post_report_new' do
    context "投稿の通報ページが表示される" do
      before do
        sign_in @another_user
        get :post_report_new, params: {post_id: @post.id}
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
    context "未ログインユーザーが新規通報ページにアクセスした場合" do
      before do
        get :post_report_new, params: {post_id: @post.id}
      end
      it '正常なレスポンスが返ってきていないか' do
        expect(response).to_not be_success
      end
      it 'リクエストが302 となること' do
        expect(response.status).to eq 302
      end
      it 'ログイン画面へリダイレクトされているか' do
        expect(response).to redirect_to user_session_path
      end
    end
  end
  
  describe 'post_report_create' do
    context "正常に通報が作成されているか" do
      before do
        sign_in @another_user
        @post_report = Report.new
        @post_report.category = 1
        @post_report.message = "テスト投稿"
        @post_report.user_id = 2
        @post_report.post_id = 1
        @post_report.question_id = nil
        @post_report.save
      end
      it "通報の作成ができているか" do
        expect(@post_report).to be_valid
      end
    end
    context "データが正しく保存されない" do
      before do
        sign_in @another_user
        @post_report = Report.new
        @post_report.category = 1
        @post_report.message = nil
        @post_report.user_id = 2
        @post_report.post_id = 1
        @post_report.question_id = nil
        @post_report.save
      end
      it "通報の作成ができているか" do
        expect(@post_report).to be_invalid
        expect(@post_report.errors[:message]).to include("を入力してください")
      end
    end
  end

  describe 'question_report_new' do
    context "質問の通報ページが表示される" do
      before do
        sign_in @another_user
        get :question_report_new, params: {question_id: @question.id}
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
    context "未ログインユーザーが新規通報ページにアクセスした場合" do
      before do
        get :question_report_new, params: {question_id: @question.id}
      end
      it '正常なレスポンスが返ってきていないか' do
        expect(response).to_not be_success
      end
      it 'リクエストが302 となること' do
        expect(response.status).to eq 302
      end
      it 'ログイン画面へリダイレクトされているか' do
        expect(response).to redirect_to user_session_path
      end
    end
  end
  
  describe 'question_report_create' do
    context "正常に通報が作成されているか" do
      before do
        sign_in @another_user
        @question_report = Report.new
        @question_report.category = 1
        @question_report.message = "テスト投稿"
        @question_report.user_id = 2
        @question_report.post_id = nil
        @question_report.question_id = 1
        @question_report.save
      end
      it "通報の作成ができているか" do
        expect(@question_report).to be_valid
      end
    end
    context "データが正しく保存されない" do
      before do
        sign_in @another_user
        @question_report = Report.new
        @question_report.category = 1
        @question_report.message = nil
        @question_report.user_id = 2
        @question_report.post_id = nil
        @question_report.question_id = 1
        @question_report.save
      end
      it "通報の作成ができているか" do
        expect(@question_report).to be_invalid
        expect(@question_report.errors[:message]).to include("を入力してください")
      end
    end
  end
end