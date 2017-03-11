require 'rails_helper'

RSpec.describe Genre, type: :model do
  it 'Has a name' do
    g = Genre.create! name: 'Jazz'
    expect(g.name).to eq('Jazz')
  end

  it 'Requires a name' do
    g = Genre.create
    expect(g.valid?).to be_falsey
  end

  it 'Has asociated songs' do
    g = Genre.create! name: 'Ska'
    g.songs << create(:song)
    g.songs << create(:song, :different)
    expect(g.songs.count).to eq(2)
  end
end
