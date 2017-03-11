FactoryGirl.define do
  factory :genre do
    name "Genre name"

    trait :with_songs do
      after(:create) do |genre, evaluator|
        create_list(:song, 3, genre: genre)
      end
    end
  end
end
