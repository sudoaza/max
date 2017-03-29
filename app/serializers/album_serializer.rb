class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_many :songs, serializer: SongSerializer
  belongs_to :art, serializer: ArtSerializer
  belongs_to :artist, serializer: ArtistSerializer
end
