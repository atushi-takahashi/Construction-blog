FactoryBot.define do
  factory :post_like, class: Like do
    user_id { 1 }
    post_id { 1 }
    question_id { nil }
  end
  factory :question_like, class: Like do
    user_id { 1 }
    post_id { nil }
    question_id { 1 }
  end
end
