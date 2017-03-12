require 'rails_helper'

RSpec.describe Genre, type: :model do
  it 'has a name' do
    g = create :genre, name: 'Jazz'
    expect(g.name).to eq('Jazz')
  end

  it 'requires a name' do
    g = create :genre, name: nil
    expect(g.valid?).to be_falsey
  end

  it 'has songs' do
    g = create :genre
    g.songs << create(:song)
    g.songs << create(:song, :different)
    expect(g.songs.count).to eq(2)
    expect(g.songs.first).to be_a(Song)
  end
end
