require 'rails_helper'

describe API::V1::Artists do
  let(:subject) { create(:artist) }
  let(:subject_params) { build(:artist).slice(:name, :bio) }

  describe 'creating' do
    let(:url) { '/api/v1/artists' }
    context 'works' do
      it 'creates an artist' do
        expect {
          post url, subject_params.to_json, json_request
        }.to change{ Artist.count }.by(1)
        expect(response.status).to eq(201)
      end
    end
    context 'failing' do
      it "if trying to create without a name" do
        post url, {name: '', bio: 'Band without a name'}.to_json, json_request
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'getting' do
    context 'works' do
      it 'gets the artist list' do
        get "/api/v1/artists"
        expect(response.body).to eq(Artist.all.to_json)
      end
      it 'returns an artist' do
        serializable = ArtistSerializer.new(subject)
        get "/api/v1/artists/#{subject.id}"
        expect(response.body).to eq(serializable.to_json)
      end
    end
    context 'failing' do
      it "if getting an artist doesn't exist" do
        get "/api/v1/artists/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'updating' do
    let(:url) { "/api/v1/artists/#{subject.id}" }
    context 'works' do
      it 'updates an artist' do
        subject.name = 'new name'
        subject.bio = 'new bio'
        put url, subject.slice(:name,:bio).to_json,
            json_request
        expect(response.status).to eq(200)
        subject.reload
        expect(subject.name).to eq('new name')
        expect(subject.bio).to eq('new bio')
      end
    end
    context 'failing' do
      it "if updating an artist doesn't exist" do
        put "/api/v1/artists/9999", {name: 'testing'}.to_json, json_request
        expect(response.status).to eq(404)
      end
      it "if trying to update without a name" do
        put url, {name: ''}.to_json, json_request
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'deleting' do
    context 'works' do
      it 'deletes an artist' do
        subject # let is lazy
        expect {
          delete "/api/v1/artists/#{subject.id}"
        }.to change{ Artist.count }.by(-1)
        expect(response.status).to eq(204)
      end
    end
    context 'failing' do
      it 'cannot delete if not existing' do
        delete "/api/v1/artists/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'adding an album' do
    let(:url) { "/api/v1/artists/#{subject.id}/add_album" }
    context 'works' do
      it 'adds an album' do
        album = create(:album)
        put url, {album_id: album.id}.to_json, json_request
        subject.reload
        expect(subject.albums).to include(album)
        expect(response.status).to eq(200)
      end
    end
    context 'failing' do
      it "if trying to add a non existing album" do
        put url, {album_id: 321}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'removing an album' do
    let(:url) { "/api/v1/artists/#{subject.id}/remove_album" }
    context 'works' do
      it 'removes a related album' do
        album = create(:album)
        subject.albums << album
        subject.save
        put url, {album_id: album.id}.to_json, json_request
        subject.reload
        expect(subject.albums).not_to include(album)
        expect(response.status).to eq(200)
      end
    end
    context 'failing' do
      it "if trying to remove a non related album" do
        put url, {album_id: 321}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'adding a song' do
    let(:url) { "/api/v1/artists/#{subject.id}/add_song" }
    context 'works' do
      it 'if both exist' do
        song = create(:song)
        put url, {song_id: song.id}.to_json, json_request
        subject.reload
        expect(subject.songs).to include(song)
        expect(response.status).to eq(200)
      end
    end
    context 'failing' do
      it "if trying to add a non existing unpublished song" do
        put url, {song_id: 321}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'removing a song' do
    let(:url) { "/api/v1/artists/#{subject.id}/remove_song" }
    context 'works' do
      it "if trying to remove a related unpublished song" do
        song = create :song
        subject.songs << song
        subject.save
        put url, {song_id: song.id}.to_json, json_request
        subject.reload
        expect(subject.songs).not_to include(song)
        expect(response.status).to eq(200)
      end
    end
    context 'failing' do
      it "if trying to remove a non related unpublished song" do
        put url, {song_id: 321}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end
end
