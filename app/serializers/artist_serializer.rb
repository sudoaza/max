class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :albums, :created_at, :updated_at
end
