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

  context 'has artist directly' do
    let(:song) { create :song, :with_artist }
    it 'is private' do
       expect { song.artist }.to raise_error(NoMethodError)
    end
    it 'has an Artist' do
      expect(song.show_artist).to be_a(Artist)
    end
    it 'is valid' do
      expect(song).to be_valid
    end
    it 'persistes the artist' do
      artist = song.show_artist
      song.reload
      expect(song.show_artist).to eq(artist)
    end
    context 'receives an album' do
      let(:album) { create :album }
      it 'is invalid' do
        song.album = album
        expect(song).to_not be_valid
      end
      it 'is valid if you unset the artist' do
        song.artist = nil
        song.album = album
        expect(song).to be_valid
      end
    end
  end

  context 'has artist through album' do
    let(:song) {create :song, :with_album}
    it 'has an Album' do
      expect(song.album).to be_a(Album)
    end
    it 'is valid' do
      expect(song).to be_valid
    end
    it 'persistes the album' do
      album = song.album
      song.reload
      expect(song.album).to eq(album)
    end
    context 'receives an artist' do
      let(:artist) { create :artist }
      it 'is invalid' do
        song.artist = artist
        expect(song).to_not be_valid
      end
      it 'is valid if you unset the album' do
        song.album = nil
        song.artist = artist
        expect(song).to be_valid
      end
    end
  end

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

  describe 'serializer' do
    let(:subject) { create :song, :rock, :with_album, :is_featured }
    let(:serialized) { SongSerializer.new(subject).as_json }
    context 'has field' do
      it 'name' do
        expect(serialized[:name]).to_not be_nil
      end
      it 'duration' do
        expect(serialized[:duration]).to_not be_nil
      end
      it 'show_artist' do
        expect(serialized[:show_artist][:id]).to_not be_nil
      end
      it 'genre name' do
        expect(serialized[:genre][:name]).to_not be_nil
      end
      it 'album' do
        expect(serialized[:album][:id]).to_not be_nil
      end
      it 'featured history' do
        expect(serialized[:featured][:history]).to_not be_nil
      end
      it 'featured art' do
        expect(serialized[:featured][:art][:id]).to_not be_nil
      end
    end
  end
end
