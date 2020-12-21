require 'rails_helper'

RSpec.describe User::CommentsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @category = FactoryBot.create(:category)
    @post = FactoryBot.create(:post)
    @question = FactoryBot.create(:question)
    @post_comment = FactoryBot.create(:post_comment)
    @question_comment = FactoryBot.create(:question_comment)
  end
  describe '#post_create' do
    context "投稿にコメントが作成されるか" do
      before do
        sign_in @user
        @post_comment = Comment.new
        @post_comment.message = "テストコメント"
        @post_comment.user_id = 1
        @post_comment.post_id = 1
        @post_comment.question_id = nil
        @post_comment.save
      end
      it '投稿にコメントが作成できるか？' do
        expect(@post_comment).to be_valid
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
    context "データが正しく保存されない" do
      before do
        sign_in @user
        @post_comment = Comment.new
        @post_comment.message = nil
        @post_comment.user_id = 1
        @post_comment.post_id = 1
        @post_comment.question_id = nil
        @post_comment.save
      end
      it '投稿にコメントが作成できるか？' do
        expect(@post_comment).to be_invalid
      end
    end
  end

  describe '#post_destroy' do
    context "投稿のコメントが削除されるか" do
      before do
        sign_in @user
      end
      it '正常にコメントが削除されるか' do
        # Ajaxのときはxhr: trueを記述
        expect{
          delete :post_destroy,xhr: true, params: {post_id: @post.id, id: @post_comment.id}
        }.to change(@user.comments, :count).by(-1)
      end
    end
  end
  
  describe '#question_create' do
    context "質問にコメントが作成されるか" do
      before do
        sign_in @user
        @question_comment = Comment.new
        @question_comment.message = "テストコメント"
        @question_comment.user_id = 1
        @question_comment.post_id = nil
        @question_comment.question_id = 1
        @question_comment.save
      end
      it '質問にコメントが作成できるか？' do
        expect(@question_comment).to be_valid
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
    context "データが正しく保存されない" do
      before do
        sign_in @user
        @question_comment = Comment.new
        @question_comment.message = nil
        @question_comment.user_id = 1
        @question_comment.post_id = nil
        @question_comment.question_id = 1
        @question_comment.save
      end
      it '質問にコメントが作成できるか？' do
        expect(@question_comment).to be_invalid
      end
    end
  end

  describe '#question_destroy' do
    context "質問のコメントが削除されるか" do
      before do
        sign_in @user
      end
      it '正常にコメントが削除されるか' do
        # Ajaxのときはxhr: trueを記述
        expect{
          delete :question_destroy,xhr: true, params: {question_id: @question.id, id: @question_comment.id}
        }.to change(@user.comments, :count).by(-1)
      end
    end
  end
end