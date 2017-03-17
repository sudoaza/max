require 'rails_helper'

describe API::V1::Playlists do
  let(:subject) { create(:playlist) }
  let(:subject_params) { build(:playlist).slice(:name) }

  describe 'creating' do
    let(:url) { '/api/v1/playlists' }
    context 'works' do
      it 'creates an playlist' do
        expect {
          post url, subject_params.to_json, json_request
        }.to change{ Playlist.count }.by(1)
        expect(response.status).to eq(201)
      end
    end
    context 'failing' do
      it "if trying to create without a name" do
        post url, {name: ''}.to_json, json_request
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'getting' do
    context 'works' do
      it 'gets the list' do
        get "/api/v1/playlists"
        expect(response.body).to eq(Playlist.all.to_json)
      end
      it 'returns an playlist' do
        serializable = PlaylistSerializer.new(subject)
        get "/api/v1/playlists/#{subject.id}"
        expect(response.body).to eq(serializable.to_json)
      end
    end
    context 'failing' do
      it "if getting a playlist that doesn't exist" do
        get "/api/v1/playlists/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'updating' do
    let(:url) { "/api/v1/playlists/#{subject.id}" }
    context 'works' do
      it 'updates an playlist' do
        subject.name = 'new name'
        put url, subject.slice(:name).to_json, json_request
        expect(response.status).to eq(200)
        subject.reload
        expect(subject.name).to eq('new name')
      end
    end
    context 'failing' do
      it "if updating an playlist doesn't exist" do
        put "/api/v1/playlists/9999", subject_params.to_json, json_request
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
      it 'deletes an playlist' do
        subject # let is lazy
        expect {
          delete "/api/v1/playlists/#{subject.id}"
        }.to change{ Playlist.count }.by(-1)
        expect(response.status).to eq(204)
      end
    end
    context 'failing' do
      it 'cannot delete if not existing' do
        delete "/api/v1/playlists/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'adding a song' do
    let(:url) { "/api/v1/playlists/#{subject.id}/add_song" }
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
      it "if trying to add a non existing song" do
        put url, {song_id: 321}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'removing a song' do
    let(:url) { "/api/v1/playlists/#{subject.id}/remove_song" }
    context 'works' do
      it "if trying to remove a related song" do
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
      it "if trying to remove a non related song" do
        put url, {song_id: 321}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end
end
