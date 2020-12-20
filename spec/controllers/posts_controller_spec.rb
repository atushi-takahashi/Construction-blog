require 'rails_helper'

RSpec.describe User::PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @post = FactoryBot.create(:post)
    @another_user = FactoryBot.create(:another_user)
  end
  describe 'new' do
    context "新規投稿ページが正しく表示される" do
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

    context "新規投稿ページが正しく表示される" do
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
    context '正常に記事投稿が作成されるか' do
      before do
        sign_in @user
        @post = Post.new
        @post.title = "テスト投稿"
        @post.body = "テスト内容"
        @post.status = "投稿"
        @post.user_id = 1
        @post.category_id = 1
        @post.save
      end
      it '記事の作成ができるか？' do
        expect(@post).to be_valid
      end
    end
    context "データが正しく保存されない" do
      before do
        @post = Post.new
        @post.title = ""
        @post.body = "テスト内容"
        @post.status = "投稿"
        @post.user_id = 1
        @post.category_id = 1
        @post.save
      end
      it "titleが入力されていないので保存されない" do
        expect(@post).to be_invalid
        expect(@post.errors[:title]).to include("を入力してください")
      end
    end
  end

  describe "#show" do
    context "投稿詳細ページが正しく表示される" do
      before do
        sign_in @user
        get :show, params: {id: @post.id}
      end
      it '正常なレスポンスかどうか' do
        expect(response).to be_success
      end
      it 'ログイン時の投稿詳細ページのリクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "未ログイン時投稿詳細ページが正しく表示される" do
      before do
        get :show, params: {id: @post.id}
      end
      it '正常なレスポンスかどうか' do
        expect(response).to be_success
      end
      it '未ログイン時投稿詳細ページのリクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe "#edit" do
    context "投稿者が投稿編集ページにアクセスした場合" do
      before do
        sign_in @user
        get :edit, params: {id: @post.id}
      end
      it '正常なレスポンスかどうか' do
        expect(response).to be_success
      end
      it 'ログイン時の投稿編集ページのリクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "未ログインユーザーが投稿編集ページにアクセスした場合" do
      before do
        get :edit, params: {id: @post.id}
      end
      it '正常なレスポンスが返ってきてないかどうか' do
        expect(response).to_not be_success
      end
      it '未ログイン時投稿編集ページのリクエストは302 OKとなること' do
        expect(response.status).to eq 302
      end
      it '未ログイン時投稿編集ページアクセスした時のログイン画面に切り替わる' do
        expect(response).to redirect_to user_session_path
      end
    end

    context "投稿者じゃないユーザーが投稿編集ページにアクセスした場合" do
      before do
        sign_in @another_user
        get :edit, params: {id: @post.id}
      end
      it '正常なレスポンスか返ってきてないかどうか' do
        expect(response).to_not be_success
      end
      it '未ログイン時投稿編集ページのリクエストは302 OKとなること' do
        expect(response.status).to eq 302
      end
      it '未ログイン時投稿編集ページアクセスした時のログイン画面に切り替わる' do
        expect(response).to redirect_to '/'
      end
    end

    describe "#update" do
      context "投稿の更新" do
        before do
          sign_in @user
        end
        it '正常にタイトルがアップデートされるか' do
          post_params = {title: "更新タイトル"}
          patch :update, params: {id: @post.id, post: post_params}
          expect(@post.reload.title).to eq "更新タイトル"
        end
        it '投稿更新後、投稿詳細ページにリダイレクトされるか' do
          post_params = {title: "更新タイトル"}
          patch :update, params: {id: @post.id, post: post_params}
          expect(response).to redirect_to post_path(@post.id)
        end
        it '入力不備の場合にアップデートされていないか' do
          post_params = {title: nil}
          patch :update, params: {id: @post.id, post: post_params}
          expect(@post.reload.title).to eq "テストタイトル"
        end
        it '入力不備があった場合に編集ページにリダイレクトされているか' do
          post_params = {title: nil}
          patch :update, params: {id: @post.id, post: post_params}
          expect(response).to redirect_to "/posts/#{@post.id}/edit"
        end
      end
    end
    
    describe "#destroy" do
      context "投稿者の投稿削除" do
        before do
          sign_in @user
        end
        it '正常に投稿を削除できるか' do
          expect{
            delete :destroy, params: {id: @post.id}
          }.to change(@user.posts, :count).by(-1)
        end
        it '削除後の、ユーザー詳細ページにリダイレクトされるか' do
          delete :destroy, params: {id: @post.id}
          expect(response).to redirect_to user_path(@post.user_id)
        end
      end
    end
  end
end