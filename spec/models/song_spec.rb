require 'rails_helper'

RSpec.describe Song, type: :model do
  it 'Has a name and duration' do
    s = Song.create! name: 'Californication', duration: 123
    expect(s.name).to eq('Californication')
    expect(s.duration).to eq(123)
  end

  it 'Requires a name' do
    s = Song.create duration: 125
    expect(s.valid?).to be_falsey
  end

  it 'Requires a duration' do
    s = Song.create name: 'Some song'
    expect(s.valid?).to be_falsey
  end

  it 'Can have a genre' do
    s = Song.create! name: 'Californication', duration: 124, genre: create(:genre)
    expect(s.genre).to be_a(Genre)
  end

  it 'Can have an artist'

  it 'Can have an album'
end
