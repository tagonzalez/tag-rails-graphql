module JsonPlaceholderMockHelper
  URI = Rails.application.credentials.json_placeholder_url

  def mock_album_request
    stub_request(:get, "#{URI}/albums/2")
      .to_return(
        status: :ok,
        body: File.read('./spec/support/fixtures/json_placeholder_album_request.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def mock_photos_by_album_id_request
    stub_request(:get, "#{URI}/photos/?albumId=2")
      .to_return(
        status: :ok,
        body: File.read('./spec/support/fixtures/json_placeholder_photos_by_album_request.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
