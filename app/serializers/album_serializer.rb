class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :songs, :art, :created_at, :updated_at
end
