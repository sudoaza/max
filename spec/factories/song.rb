FactoryGirl.define do
  factory :song do
    name "Le song name"
    duration 123

    trait :different do
      name "Song 2"
      duration 456
    end

    trait :rock do
      name "House of the Rising Sun"
      association :genre, :rock
    end

    trait :with_artist do
      association :artist
    end

    trait :with_album do
      association :album
    end

    trait :is_featured do
      after(:create) do |song, evaluator|
        song.featured= create(:featured, song: song)
      end
    end
  end
end
