require 'rails_helper'

RSpec.describe Album, type: :model do
  it 'has a name' do
    album = create :album, name: 'Some name'
    expect(album.name).to eq('Some name')
  end

  it 'requires a name' do
    album = build :album, name: nil
    expect(album).to_not be_valid
  end

  context 'art' do
    let(:album) { create :album, :with_art }
    it 'has one' do
      expect(album.art).to be_a(Art)
    end
    it 'is optional' do
      album.art = nil
      expect(album).to be_valid
    end
  end

  it 'has songs' do
    album = create(:album, :with_songs, songs_count: 3)
    expect(album.songs.count).to eq(3)
    expect(album.songs.first).to be_a(Song)
  end

  context 'artist' do
    let(:album) { create :album }
    it 'has one' do
      expect(album.artist).to be_a(Artist)
    end
    it 'is required' do
      album.artist = nil
      expect(album).to_not be_valid
    end
  end
end
