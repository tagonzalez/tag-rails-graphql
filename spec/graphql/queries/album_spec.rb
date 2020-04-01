require 'rails_helper'

describe Queries::Album, type: :request do
  include JsonPlaceholderMockHelper

  describe '.resolve' do
    subject(:make_request) { post '/graphql', params: { query: query } }

    let(:album_id) { 2 }
    let(:query) do
      <<~GQL
        query {
          album (id: "#{album_id}") {
            id
            title
            userId
            photos {
                id
                title
                url
                thumbnailUrl
            }
          }
        }
      GQL
    end

    before do
      mock_album_request
      mock_photos_by_album_id_request
      make_request
    end

    it 'makes an external request for an album' do
      expect(a_request(:get, "jsonplaceholder.typicode.com/albums/#{album_id}"))
        .to have_been_made
    end

    it 'makes an external request for the albums photos' do
      expect(a_request(:get, "jsonplaceholder.typicode.com/photos/?albumId=#{album_id}"))
        .to have_been_made
    end

    it 'returns a data property in the response body' do
      expect(JSON.parse(response.body)).to include('data')
    end

    it 'returns with an albums information' do
      response_data = JSON.parse(response.body)['data']
      expect(response_data).to include('album')

      response_album = response_data['album']
      expect(response_album).to include('id', 'title', 'photos')
    end

    it "returns with an albums' photos info" do
      response_photos = JSON.parse(response.body)['data']['album']['photos']
      expect(response_photos).to all(include('id', 'title', 'url', 'thumbnailUrl'))
    end

    it 'responds with ok status code' do
      expect(response).to have_http_status :ok
    end
  end
end
