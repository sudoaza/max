require 'rails_helper'

describe API::V1::Genres do
  describe 'getting' do
    context 'works' do
      it 'gets the genre list' do
        get "/api/v1/genres"
        expect(response.body).to eq(Genre.all.to_json)
      end
    end
  end
end
