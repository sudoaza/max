FactoryGirl.define do
  factory :featured do
    history "Some text field with the history of the featured song."
    association :art
    association :song
  end
end
