class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :created_at, :updated_at

  belongs_to :show_artist, serializer: ArtistSerializer
  belongs_to :album, serializer: AlbumSerializer
  belongs_to :genre, serializer: GenreSerializer

  has_one :featured

  class FeaturedSerializer < ActiveModel::Serializer
      attributes :history, :art
  end
end
