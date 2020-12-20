FactoryBot.define do
  factory :user, class: User do
    name {"test-name"}
    email {"test@example.com"}
    password {"password"}
  end
  factory :another_user, class: User do
    name {"test-name2"}
    email {"test2@example.com"}
    password {"password2"}
  end
end
