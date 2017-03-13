FactoryGirl.define do
  factory :playlist do
    name 'My test playlist'

    trait :with_songs do
      transient do
        songs_count 5
      end

      after(:create) do |playlist, evaluator|
        songs { create_list :song, songs_count }
      end
    end
  end
end
