require 'rails_helper'

describe API::V1::Albums do
  let(:subject) { create(:album) }
  let(:subject_params) { build(:album).slice(:name, :artist_id) }

  describe 'creating' do
    let(:url) { '/api/v1/albums' }
    context 'works' do
      it 'creates an album' do
        expect {
          post url, subject_params.to_json, json_request
        }.to change{ Album.count }.by(1)
        expect(response.status).to eq(201)
      end
      it 'with art' do
        art = create :art
        subject_params[:art_id] = art.id
        expect {
          post url, subject_params.to_json, json_request
        }.to change{ Album.count }.by(1)
        expect(response.status).to eq(201)
        expect(Album.last.art).to eq(art)
      end
    end
    context 'failing' do
      it "if trying to create without a name" do
        post url, {name: '', artist_id: subject.artist_id}.to_json, json_request
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'getting' do
    context 'works' do
      it 'gets the list' do
        get "/api/v1/albums"
        expect(response.body).to eq(Album.all.to_json)
      end
      it 'returns an album' do
        serializable = AlbumSerializer.new(subject)
        get "/api/v1/albums/#{subject.id}"
        expect(response.body).to eq(serializable.to_json)
      end
    end
    context 'failing' do
      it "if getting an album doesn't exist" do
        get "/api/v1/albums/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'updating' do
    let(:url) { "/api/v1/albums/#{subject.id}" }
    context 'works' do
      it 'updates an album' do
        subject.name = 'new name'
        put url, subject.slice(:name).to_json, json_request
        expect(response.status).to eq(200)
        subject.reload
        expect(subject.name).to eq('new name')
      end
      it 'updates the art' do
        art = create :art
        put url, {art_id: art.id}.to_json, json_request
        expect(response.status).to eq(200)
        subject.reload
        expect(subject.art).to eq(art)
      end
    end
    context 'failing' do
      it "if updating an album doesn't exist" do
        put "/api/v1/albums/9999", subject_params.to_json, json_request
        expect(response.status).to eq(404)
      end
      it "if trying to update without a name" do
        put url, {name: ''}.to_json, json_request
        expect(response.status).to eq(422)
      end
      it 'without a valid art' do
        put url, {art_id: '1234'}.to_json, json_request
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'deleting' do
    context 'works' do
      it 'deletes an album' do
        subject # let is lazy
        expect {
          delete "/api/v1/albums/#{subject.id}"
        }.to change{ Album.count }.by(-1)
        expect(response.status).to eq(204)
      end
    end
    context 'failing' do
      it 'cannot delete if not existing' do
        delete "/api/v1/albums/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'adding a song' do
    let(:url) { "/api/v1/albums/#{subject.id}/add_song" }
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
    let(:url) { "/api/v1/albums/#{subject.id}/remove_song" }
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
