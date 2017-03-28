require 'rails_helper'

RSpec.describe Featured, type: :model do
  let(:featured) { create :featured }
  context 'art' do
    it 'has one' do
      expect(featured.art).to be_a(Art)
    end
    it 'is required' do
      featured.art = nil
      expect(featured).to_not be_valid
    end
  end

  context 'song' do
    it 'has one' do
      expect(featured.song).to be_a(Song)
    end
    it 'is required' do
      featured.song = nil
      expect(featured).to_not be_valid
    end
  end

  context 'history' do
    let(:featured_with_history) {
      featured.history = 'some history'
      featured.save
      featured
    }
    it 'has one' do
      expect(featured_with_history).to be_valid
      featured.reload
      expect(featured_with_history.history).to eq('some history')
    end
    it 'is optional' do
      featured_with_history.history = nil
      expect(featured_with_history).to be_valid
    end
  end
end
