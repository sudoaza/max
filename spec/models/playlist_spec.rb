require 'rails_helper'

RSpec.describe Playlist, type: :model do
  it 'has a name' do
    playlist = create :playlist, name: 'My playlist'
    expect(playlist.name).to eq('My playlist')
  end

  it 'requires a name' do
    playlist = create :playlist, name: nil
    expect(playlist).to_not be_valid
  end

  it 'has songs' do
    playlist = create :playlist, :with_songs, songs_count: 4
    expect(playlist.songs.count).to eq(4)
    expect(playlist.songs.first).to be_a(Song)
  end
end
