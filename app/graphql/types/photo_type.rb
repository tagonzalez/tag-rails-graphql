module Types
  class PhotoType < BaseObject
    field :album_id, ID, null: false
    field :id, ID, null: false
    field :url, String, null: false
    field :thumbnail_url, String, null: false
    field :title, String, null: false
  end
end
