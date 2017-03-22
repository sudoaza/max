require 'rails_helper'

describe API::V1::Songs do
  let(:subject) { create(:song) }
  let(:subject_params) { build(:song).slice(:name, :duration) }

  describe 'creating' do
    let(:url) { '/api/v1/songs' }
    context 'works' do
      it 'creates a song' do
        expect {
          post url, subject_params.to_json, json_request
        }.to change{ Song.count }.by(1)
        expect(response.status).to eq(201)
      end
    end
    context 'failing' do
      it "if trying to create without a name" do
        subject_params[:name] = ''
        post url, subject_params.to_json, json_request
        expect(response.status).to eq(422)
      end
      it "if trying to create without a duration" do
        subject_params[:duration] = nil
        post url, subject_params.to_json, json_request
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'getting' do
    context 'works' do
      it 'returns a song' do
        serializable = SongSerializer.new(subject)
        get "/api/v1/songs/#{subject.id}"
        expect(response.body).to eq(serializable.to_json)
      end
    end
    context 'failing' do
      it "if getting a song that doesn't exist" do
        get "/api/v1/songs/9999"
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'updating' do
    let(:url) { "/api/v1/songs/#{subject.id}" }
    context 'works' do
      it 'updates a song' do
        subject.name = 'new name'
        subject.duration = 444
        put url, subject.slice(:name,:duration).to_json, json_request
        expect(response.status).to eq(200)
        subject.reload
        expect(subject.name).to eq('new name')
        expect(subject.duration).to eq(444)
      end
    end
    context 'failing' do
      it "if updating a song doesn't exist" do
        put "/api/v1/songs/9999", subject_params.to_json, json_request
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
      it 'deletes a song' do
        subject # let is lazy
        expect {
          delete "/api/v1/songs/#{subject.id}"
        }.to change{ Song.count }.by(-1)
        expect(response.status).to eq(204)
      end
    end
    context 'failing' do
      it 'cannot delete if not existing' do
        delete "/api/v1/songs/9999"
        expect(response.status).to eq(404)
      end
    end
  end
end
