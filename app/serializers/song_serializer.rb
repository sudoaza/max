class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :artist, :created_at, :updated_at
end
