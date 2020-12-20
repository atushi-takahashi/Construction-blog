require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
  end
  context '正常に記事が作成されるか' do
    before do
      sign_in @user
      @post = Post.new
      @post.title = "テスト投稿"
      @post.body = "テスト内容"
      @post.status = "投稿"
      @post_id = 1
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
      @post_id = 1
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