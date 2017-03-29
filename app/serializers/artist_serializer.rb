class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :albums, :songs, :created_at, :updated_at
end
