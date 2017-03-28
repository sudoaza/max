FactoryGirl.define do
  factory :album do
    name 'Album name'

    trait :with_songs do
      transient do
        songs_count 5
      end

      after(:create) do |album, evaluator|
        create_list :song, evaluator.songs_count, album: album
      end
    end

    trait :with_art do
      after(:create) do |album, evaluator|
        album.art= create(:art)
      end
    end
  end
end
