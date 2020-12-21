require 'rails_helper'

RSpec.describe User::UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end
  describe 'show' do
    context "ユーザー詳細ページが表示される" do
      before do
        sign_in @user
        get :show, params: {id: @user.id}
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'edit' do
    context "ユーザーの編集ページが表示される" do
      before do
        sign_in @user
        get :edit, params: {id: @user.id}
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "未ログインユーザーが編集ページにアクセスした場合" do
      before do
        get :edit, params: {id: @user.id}
      end
      it '正常なレスポンスが返ってきてないかどうか' do
        expect(response).to_not be_success
      end
      it '未ログイン時ユーザー編集ページのリクエストは302 OKとなること' do
        expect(response.status).to eq 302
      end
      it '未ログイン時ユーザー編集ページアクセスした時のログイン画面に切り替わる' do
        expect(response).to redirect_to user_session_path
      end
    end

    context "ログインユーザーのユーザーが編集ページじゃないページにアクセスした場合" do
      before do
        sign_in @another_user
        get :edit, params: {id: @user.id}
      end
      it '正常なレスポンスが返ってきてないかどうか' do
        expect(response).to_not be_success
      end
      it '未ログイン時ユーザー編集ページのリクエストは302 OKとなること' do
        expect(response.status).to eq 302
      end
      it '未ログイン時ユーザー編集ページアクセスした時のログイン画面に切り替わる' do
        expect(response).to redirect_to '/'
      end
    end
  end

  describe 'update' do
    context "ユーザープロフィールの更新" do
      before do
        sign_in @user
      end
      it '正常に名前がアップデートされるか' do
        user_params = {name: "TEST-USER"}
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.name).to eq "TEST-USER"
      end
      it 'プロフィール更新後、ユーザー詳細ページにリダイレクトされるか' do
        user_params = {name: "TEST-USER"}
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to user_path(@user.id)
      end
      it '入力不備の場合にアップデートされていないか' do
        user_params = {name: nil}
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.name).to eq "test-name"
      end
      it '入力不備の場合に、ユーザー編集ページにリダイレクトされるか' do
        user_params = {name: nil}
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to edit_user_path(@user.id)
      end
    end
  end
end