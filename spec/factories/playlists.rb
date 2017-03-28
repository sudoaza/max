FactoryGirl.define do
  factory :playlist do
    name 'My test playlist'

    trait :with_songs do
      transient do
        songs_count 5
      end

      after(:create) do |playlist, evaluator|
        create_list :playlist_song, evaluator.songs_count, playlist: playlist
      end
    end
  end
end
