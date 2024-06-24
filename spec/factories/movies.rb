FactoryBot.define do
  factory :movie do
    title { "Sample Movie" }
    description { "Sample Description" }
    year { 2020 }
    director
  end
end
