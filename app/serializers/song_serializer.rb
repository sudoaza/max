class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :show_artist, :album, :created_at, :updated_at

  has_one :featured

  class FeaturedSerializer < ActiveModel::Serializer
      attributes :history, :art
  end
end
