require 'rails_helper'

RSpec.describe User::QuestionsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @question = FactoryBot.create(:question)
    @another_user = FactoryBot.create(:another_user)
  end
  describe 'new' do
    context "新規質問ページが正しく表示される" do
      before do
        sign_in @user
        get :new
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "新規質問ページが正しく表示される" do
      before do
        get :new
      end
      it '正常なレスポンスが返ってないか' do
        expect(response).to_not be_success
      end
      it 'ログインしていないときのリクエストが302' do
        expect(response.status).to eq 302
      end
      it 'ログイン画面にページが切り替わる' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe 'create' do
    context '正常に質問が作成されるか' do
      before do
        sign_in @user
        @question = Question.new
        @question.title = "テストタイトル"
        @question.body = "テスト内容"
        @question.status = "質問"
        @question.user_id = 1
        @question.category_id = 1
        @question.save
      end
      it '記事の作成ができるか？' do
        expect(@question).to be_valid
      end
    end
    context "データが正しく保存されない" do
      before do
        @question = Question.new
        @question.title = ""
        @question.body = "テスト内容"
        @question.status = "質問"
        @question.user_id = 1
        @question.category_id = 1
        @question.save
      end
      it "titleが入力されていないので保存されない" do
        expect(@question).to be_invalid
        expect(@question.errors[:title]).to include("を入力してください")
      end
    end
  end

  describe "#show" do
    context "質問詳細ページが正しく表示される" do
      before do
        sign_in @user
        get :show, params: {id: @question.id}
      end
      it '正常なレスポンスかどうか' do
        expect(response).to be_success
      end
      it 'ログイン時の質問詳細ページのリクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "未ログイン時質問詳細ページが正しく表示される" do
      before do
        get :show, params: {id: @question.id}
      end
      it '正常なレスポンスかどうか' do
        expect(response).to be_success
      end
      it '未ログイン時質問詳細ページのリクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe "#edit" do
    context "質問者が質問編集ページにアクセスした場合" do
      before do
        sign_in @user
        get :edit, params: {id: @question.id}
      end
      it '正常なレスポンスかどうか' do
        expect(response).to be_success
      end
      it 'ログイン時の質問編集ページのリクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "未ログインユーザーが質問編集ページにアクセスした場合" do
      before do
        get :edit, params: {id: @question.id}
      end
      it '正常なレスポンスが返ってきてないかどうか' do
        expect(response).to_not be_success
      end
      it '未ログイン時質問編集ページのリクエストは302 OKとなること' do
        expect(response.status).to eq 302
      end
      it '未ログイン時質問編集ページアクセスした時のログイン画面に切り替わる' do
        expect(response).to redirect_to user_session_path
      end
    end

    context "質問者じゃないユーザーが質問編集ページにアクセスした場合" do
      before do
        sign_in @another_user
        get :edit, params: {id: @question.id}
      end
      it '正常なレスポンスか返ってきてないかどうか' do
        expect(response).to_not be_success
      end
      it '未ログイン時質問編集ページのリクエストは302 OKとなること' do
        expect(response.status).to eq 302
      end
      it '未ログイン時質問編集ページアクセスした時のログイン画面に切り替わる' do
        expect(response).to redirect_to '/'
      end
    end

    describe "#update" do
      context "質問の更新" do
        before do
          sign_in @user
        end
        it '正常にタイトルがアップデートされるか' do
          question_params = {title: "更新タイトル"}
          patch :update, params: {id: @question.id, question: question_params}
          expect(@question.reload.title).to eq "更新タイトル"
        end
        it '質問更新後、質問詳細ページにリダイレクトされるか' do
          question_params = {title: "更新タイトル"}
          patch :update, params: {id: @question.id, question: question_params}
          expect(response).to redirect_to question_path(@question.id)
        end
        it '入力不備の場合にアップデートされていないか' do
          question_params = {title: nil}
          patch :update, params: {id: @question.id, question: question_params}
          expect(@question.reload.title).to eq "テストタイトル"
        end
        it '入力不備があった場合に編集ページにリダイレクトされているか' do
          question_params = {title: nil}
          patch :update, params: {id: @question.id, question: question_params}
          expect(response).to redirect_to edit_question_path(@question)
        end
      end
    end
    
    describe "#destroy" do
      context "質問者の質問削除" do
        before do
          sign_in @user
        end
        it '正常に質問を削除できるか' do
          expect{
            delete :destroy, params: {id: @question.id}
          }.to change(@user.questions, :count).by(-1)
        end
        it '削除後の、ユーザー詳細ページにリダイレクトされるか' do
          delete :destroy, params: {id: @question.id}
          expect(response).to redirect_to user_path(@question.user_id)
        end
      end
    end
  end
end