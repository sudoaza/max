require 'rails_helper'

RSpec.describe Song, type: :model do
  it 'has a name and duration' do
    s = create :song, name: 'Californication', duration: 123
    expect(s.name).to eq('Californication')
    expect(s.duration).to eq(123)
  end

  it 'requires a name' do
    s = create :song, name: nil
    expect(s.valid?).to be_falsey
  end

  it 'requires a duration' do
    s = create :song, duration: nil
    expect(s.valid?).to be_falsey
  end

  it 'is not valid if duration is not numeric' do
    s = create :song, duration: 'bad'
    expect(s.valid?).to be_falsey
  end

  it 'is not valid if duration is zero or less' do
    s = create :song, duration: -1
    expect(s.valid?).to be_falsey
  end

  it 'can have a genre' do
    s = create :song, :rock
    expect(s.genre).to be_a(Genre)
  end

  it 'can have an artist' do
    s = create :song, :with_artist
    expect(s.artist).to be_a(Artist)
  end

  it 'can have an album' do
    s = create :song, :with_album
    expect(s.album).to be_a(Album)
  end

  it 'cant have both artist and album'
  it 'has the artist of the album'
  it 'can be featured'
end
