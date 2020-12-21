require 'rails_helper'

RSpec.describe User::LikesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @category = FactoryBot.create(:category)
    @post = FactoryBot.create(:post)
    @question = FactoryBot.create(:question)
    @post_like = FactoryBot.create(:post_like)
    @question_like = FactoryBot.create(:question_like)
  end
  describe '#post_like' do
    context "投稿にいいねが作成されるか" do
      before do
        sign_in @user
        @post_like = Like.new
        @post_like.user_id = 1
        @post_like.post_id = 1
        @post_like.question_id = nil
        @post_like.save
      end
      it '投稿にいいねが作成できるか？' do
        expect(@post_like).to be_valid
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe '#post_destroy' do
    context "投稿のいいねが削除されるか" do
      before do
        sign_in @user
      end
      it '正常にいいねが削除されるか' do
        # Ajaxのときはxhr: trueを記述
        expect{
          delete :post_unlike,xhr: true, params: {post_id: @post.id, id: @post_like.id}
        }.to change(@user.likes, :count).by(-1)
      end
    end
  end
  
  describe '#question_like' do
    context "投稿にいいねが作成されるか" do
      before do
        sign_in @user
        @question_like = Like.new
        @question_like.user_id = 1
        @question_like.post_id = 1
        @question_like.question_id = nil
        @question_like.save
      end
      it '投稿にいいねが作成できるか？' do
        expect(@question_like).to be_valid
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

  describe '#question_destroy' do
    context "投稿のいいねが削除されるか" do
      before do
        sign_in @user
      end
      it '正常にいいねが削除されるか' do
        # Ajaxのときはxhr: trueを記述
        expect{
          delete :question_unlike,xhr: true, params: {question_id: @question.id, id: @question_like.id}
        }.to change(@user.likes, :count).by(-1)
      end
    end
  end
end