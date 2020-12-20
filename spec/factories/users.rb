FactoryBot.define do
  factory :user do
    # sequence(:name) { |n| "TEST_NAME#{n}"}
    # sequence(:email) { |n| "TEST#{n}@example.com"}
    # sequence(:password) { |testpass| "TEST_PASS#{testpass}"}
    name {"test-name"}
    email {"test@example.com"}
    password {"password"}
  end
end
