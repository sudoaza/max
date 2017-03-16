class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :songs, :created_at, :updated_at
end
