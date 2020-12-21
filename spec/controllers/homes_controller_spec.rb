require 'rails_helper'

RSpec.describe User::HomesController, type: :controller do
  before do
  end
  describe 'about' do
    context "Aboutページが表示される" do
      before do
        get :about
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
    
    context "一覧ページが表示される" do
      before do
        get :index
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
    
    context "検索ページが表示される" do
      before do
        get :search
      end
      it '正常なレスポンスか' do
        expect(response).to be_success
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end