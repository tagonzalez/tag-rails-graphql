module Types
  class QueryType < Types::BaseObject
    field :album, AlbumType, null: false do
      description 'Find a user by id'
      argument :id, String, required: true
    end

    def album(params)
      AlbumsService.new(params).full_album_info
    end
  end
end
