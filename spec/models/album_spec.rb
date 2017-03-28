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

  it 'has art' do
    album = create :album, :with_art
    expect(album.art).to be_a(Art)
  end

  it 'has optional art' do
    album = create :album, :with_art
    album.art = nil
    expect(album).to be_valid
  end

  it 'has songs' do
    album = create(:album, :with_songs, songs_count: 3)
    expect(album.songs.count).to eq(3)
    expect(album.songs.first).to be_a(Song)
  end
end
