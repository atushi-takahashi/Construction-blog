FactoryBot.define do
  factory :question do
    title {"テストタイトル"}
    body {"テスト内容"}
    status {"質問"}
    category_id { 1 }
    user_id { 1 }
  end
end
