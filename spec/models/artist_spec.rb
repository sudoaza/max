require 'rails_helper'

RSpec.describe Artist, type: :model do
  it 'has name' do
    a = create :artist, name: 'John Lennon'
    expect(a.name).to eq('John Lennon')
  end

  it 'requires name' do
    a = build :artist, name: nil
    expect(a).to_not be_valid
  end

  it 'has bio' do
    a = create :artist, bio: 'Is a bio text'
    expect(a.bio).to eq('Is a bio text')
  end

  it 'has songs' do
    a = create :artist, :with_songs, songs_count: 5
    expect(a.songs.count).to eq(5)
    expect(a.songs.first).to be_a(Song)
  end
end
