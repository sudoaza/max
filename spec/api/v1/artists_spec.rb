require 'rails_helper'

describe API::V1::Artists do

  context 'when the request is valid it works' do
    it 'creates an artist' do
      post '/api/v1/artists', build(:artist).slice(:name, :bio).to_json,
          {'CONTENT_TYPE': 'application/json'}
      expect(response.status).to eq(201)
    end
    it 'gets the artist list' do
      get "/api/v1/artists"
      expect(response.body).to eq(Artist.all.to_json)
    end
    it 'returns an artist' do
      subject = create(:artist)
      get "/api/v1/artists/#{subject.id}"
      expect(JSON.parse(response.body).slice(:id, :name, :bio)
          ).to eq(subject.attributes.slice(:id, :name, :bio))
    end
    it 'updates an artist'
    it 'deletes an artist'
  end
  context 'when the requst is not valid it fails' do
    it "returns 404 if getting an artist doesn't exist"
    it "returns 404 if updating an artist doesn't exist"
    it "returns 404 if adding an album to an artist doesn't exist"
    it "returns 404 if removing an album from an artist doesn't exist"
    it "returns 422 if trying to create without a name"
    it "returns 422 if trying to update without a name"
    it "returns 422 if trying to add a non existing album"
    it "returns 422 if trying to remove a non related album"
  end
end
