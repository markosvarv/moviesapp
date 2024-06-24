FactoryBot.define do
  factory :review do
    user { "Sample User" }
    stars { 4 }
    review { "Sample Review" }
    movie
  end
end