FactoryGirl.define do
  factory :art do
    image_file_name 'image.png'
    image_content_type 'image/png'
    image_file_size 2.megabytes
    image_fingerprint '2d1a48cc1eece625a273ef4448228e37'
  end
end
