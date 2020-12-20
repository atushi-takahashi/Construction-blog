FactoryBot.define do
  factory :category do
    sequence(:name) { |category| "TEST_NAME#{category}"}
  end
end
