require 'rails_helper'

RSpec.describe Album, type: :model do
  it 'has a name' do
    a = create(:album, name: 'Some name')
    expect(a.name).to eq('Some name')
  end

  it 'requires a name' do
    a = create(:album, name: nil)
    expect(a).to_not be_valid
  end

  it 'has art'
  it 'has optional art'

  it 'has songs' do
    a = create(:album, :with_songs, songs_count: 3)
    expect(a.songs.count).to eq(3)
    expect(a.songs.first).to be_a(Song)
  end
end
