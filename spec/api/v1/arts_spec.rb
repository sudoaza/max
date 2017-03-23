require 'rails_helper'

describe API::V1::Arts do
  let(:subject) { create(:art) }
  let(:url) { '/api/v1/arts' }
  let(:serializable) { ArtSerializer.new(subject) }

  describe 'creating' do
    context 'works' do
      it 'has an ok file' do
        post url, image: Rack::Test::UploadedFile.new('spec/files/ok_cover.jpg', 'image/jpeg')
        expect(response.status).to eq(201)
      end
    end
    context 'fails' do
      it 'has a too big file'
      it 'has a file of the wrong type' do
        post url, image: Rack::Test::UploadedFile.new('spec/files/text.jpg', 'image/jpeg')
        expect(response.status).to eq(422)
      end
      it 'has a file of the wrong extension' do
        post url, image: Rack::Test::UploadedFile.new('spec/files/image.txt', 'image/jpeg')
        expect(response.status).to eq(422)
      end
      it 'sends no file' do
        post url, image: nil
        expect(response.status).to eq(422)
      end
      it 'sends a file thats already uploaded' do
        post url, image: Rack::Test::UploadedFile.new('spec/files/ok_cover.jpg', 'image/jpeg')
        expect(response.status).to eq(201)
        post url, image: Rack::Test::UploadedFile.new('spec/files/ok_cover.jpg', 'image/jpeg')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'getting' do
    context 'by id' do
      it 'works' do
        get "#{url}/#{subject.id}"
        expect(response.status).to eq(200)
        expect(response.body).to eq(serializable.to_json)
      end
      it 'fails' do
        get "#{url}/456"
        expect(response.status).to eq(404)
      end
    end
    context 'by fingerprint' do
      it 'works' do
        get "#{url}/#{subject.image_fingerprint}"
        expect(response.status).to eq(200)
        expect(response.body).to eq(serializable.to_json)
      end
      it 'fails' do
        get "#{url}/aaaaaaaaaaaaaaaaaaaaaa"
        expect(response.status).to eq(404)
      end
    end
  end
end
