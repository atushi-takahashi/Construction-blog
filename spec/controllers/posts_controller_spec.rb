require 'rails_helper'

RSpec.describe User::PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @post = FactoryBot.create(:post)
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
end