FactoryGirl.define do
  factory :genre do
    name "Genre name"

    trait :with_songs do
      transient do
        songs_count 5
      end

      after(:create) do |genre, evaluator|
        create_list(:song, evaluator.songs_count, genre: genre)
      end
    end

    trait :rock do
      name "Rock"
    end
  end
end
