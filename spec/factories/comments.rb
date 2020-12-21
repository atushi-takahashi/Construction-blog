FactoryBot.define do
  factory :post_comment, class: Comment do
    message {"テストコメント"}
    user_id { 1 }
    post_id { 1 }
    question_id { nil }
  end
  factory :question_comment, class: Comment do
    message {"テストコメント"}
    user_id { 1 }
    post_id { nil }
    question_id { 1 }
  end
end
