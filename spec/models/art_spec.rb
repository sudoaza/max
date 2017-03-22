require 'rails_helper'

RSpec.describe Art, type: :model do
    it { should have_attached_file(:image) }
    it { should validate_attachment_presence(:image) }
    it { should validate_attachment_content_type(:image).
                  allowing('image/png', 'image/gif', 'image/jpg').
                  rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:image).
                  less_than(3.megabytes) }
end
