class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  belongs_to :album
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_one :featured

  validates :name, presence: true
  validates :duration, presence: true, numericality: {
    only_integer: true, greater_than: 0 }
end
