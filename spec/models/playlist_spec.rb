require 'rails_helper'

RSpec.describe Playlist, type: :model do
  it 'has a name' do
    playlist = create :playlist, name: 'My playlist'
    expect(playlist.name).to eq('My playlist')
  end

  it 'requires a name' do
    playlist = build :playlist, name: nil
    expect(playlist).to_not be_valid
  end

  it 'has songs' do
    playlist = create :playlist, :with_songs, songs_count: 4
    expect(playlist.songs.count).to eq(4)
    expect(playlist.songs.first).to be_a(Song)
  end

  describe 'serializer' do
    let(:subject) { create :playlist, :with_songs }
    let(:serialized) { PlaylistSerializer.new(subject).as_json }
    context 'has field' do
      it 'name' do
        expect(serialized[:name]).to_not be_nil
      end
      it 'songs' do
        expect(serialized[:songs]).to respond_to(:each)
        expect(serialized[:songs].first[:id]).to_not be_nil
      end
    end
  end
end
