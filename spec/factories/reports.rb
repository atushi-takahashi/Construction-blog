FactoryBot.define do
  factory :post_report, class: Report do
    category { 0 }
    message { "テスト通報" }
    user_id { 2 }
    post_id { 1 }
    question_id { nil }
  end
  factory :question_report, class: Report do
    category { 0 }
    message { "テスト通報" }
    user_id { 2 }
    post_id { nil }
    question_id { 1 }
  end
end
