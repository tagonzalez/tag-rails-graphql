module Types
  class QueryType < Types::BaseObject
    field :album, resolver: Queries::Album
  end
end
