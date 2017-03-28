require 'rails_helper'

RSpec.describe Song, type: :model do
  it 'has a name and duration' do
    song = create :song, name: 'Californication', duration: 123
    expect(song.name).to eq('Californication')
    expect(song.duration).to eq(123)
  end

  it 'requires a name' do
    song = build :song, name: nil
    expect(song).to_not be_valid
  end

  it 'requires a duration' do
    song = build :song, duration: nil
    expect(song).to_not be_valid
  end

  it 'is not valid if duration is not numeric' do
    song = build :song, duration: 'bad'
    expect(song).to_not be_valid
  end

  it 'is not valid if duration is zero or less' do
    song = build :song, duration: -1
    expect(song).to_not be_valid
  end

  it 'is not valid with fractional duration' do
    song = build :song, duration: 123.5
    expect(song).to_not be_valid
  end

  it 'can have a genre' do
    song = create :song, :rock
    expect(song.genre).to be_a(Genre)
  end

  it 'can have an artist' do
    song = create :song, :with_artist
    expect(song.artist).to be_a(Artist)
  end

  it 'can have an album' do
    song = create :song, :with_album
    expect(song.album).to be_a(Album)
  end

  it 'cant have both artist and album'
  it 'has the artist of the album'

  context 'featured' do
    let(:song) { song = create :song, :is_featured }
    it 'can be featured' do
      expect(song.featured).to be_a(Featured)
    end

    it 'is optionally featured' do
      song.featured.delete
      expect(song).to be_valid
    end
  end
end
