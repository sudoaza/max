require 'rails_helper'

RSpec.describe Art, type: :model do
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif', 'image/jpg').
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:image).
                less_than(3.megabytes) }

  describe 'serializer' do
    let(:subject) { create :art }
    let(:serialized) { ArtSerializer.new(subject).as_json }
    context 'has field' do
      it 'image_fingerprint' do
        expect(serialized[:image_fingerprint]).to_not be_nil
      end
      it 'original' do
        expect(serialized[:original]).to_not be_nil
      end
      it 'medium' do
        expect(serialized[:medium]).to_not be_nil
      end
      it 'album' do
        expect(serialized[:thumb]).to_not be_nil
      end
    end
  end
end
