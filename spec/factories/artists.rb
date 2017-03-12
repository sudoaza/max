FactoryGirl.define do
  factory :artist do
    name 'Artist Name'
    bio 'Some bio text goes here'

    trait :with_songs do
      after(:create) do |artist, evaluator|
        songs { create_list :song, 3 }
      end
    end
  end
end
