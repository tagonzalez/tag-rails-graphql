class AlbumsService
  include HTTParty
  base_uri Rails.application.credentials.json_placeholder_url

  def initialize(params)
    @album_id = params[:id]
  end

  def full_album_info
    album = parse_album(self.class.get("/albums/#{@album_id}", options))
    photos = parse_photos(self.class.get("/photos/?albumId=#{@album_id}", options))
    album[:photos] = photos
    album
  end

  private

  def options
    { headers: { 'Content-Type': 'application/json' } }
  end

  def parse_album(response)
    response.parsed_response.transform_keys(&:underscore)
  end

  def parse_photos(response)
    response.parsed_response.map! { |e| e.transform_keys(&:underscore) }
  end
end
