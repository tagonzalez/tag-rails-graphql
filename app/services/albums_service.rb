class AlbumsService
  include HTTParty
  base_uri 'jsonplaceholder.typicode.com'

  def initialize(params)
    @album_id = params[:id]
  end

  def full_album_info
    album = parse_album(self.class.get("/albums/#{@album_id}"))
    photos = parse_photos(self.class.get("/photos/?albumId=#{@album_id}"))
    album[:photos] = photos
    album
  end

  private

  def parse_album(response)
    response.parsed_response
  end

  def parse_photos(response)
    response.parsed_response.map! { |e| e.transform_keys(&:underscore) }
  end
end
