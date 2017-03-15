class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :created_at, :updated_at
end
