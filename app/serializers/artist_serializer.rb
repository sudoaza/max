class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :created_at, :updated_at
  has_many :songs, serializer: SongSerializer
  has_many :albums, serializer: AlbumSerializer
end
