FactoryBot.define do
  factory :post do
    title {"テストタイトル"}
    body {"テスト内容"}
    status {"投稿"}
    category_id { 1 }
    user_id { 1 }
  end
end
