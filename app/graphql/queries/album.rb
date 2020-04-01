module Queries
  class Album < Queries::BaseQuery
    type Types::AlbumType, null: false

    description 'Find a user by id'
    argument :id, ID, required: true

    def resolve(params)
      AlbumsService.new(params).full_album_info
    end
  end
end
