FactoryGirl.define do
  factory :artist do
    name 'Artist Name'
    bio 'Some bio text goes here'

    trait :with_songs do
      transient do
        songs_count 5
      end

      after(:create) do |artist, evaluator|
        create_list :song, evaluator.songs_count, artist: artist
      end
    end

    trait :with_albums do
      after(:create) do |artist, evaluator|
          create_list :album, 3, artist: artist
      end
    end
  end
end
