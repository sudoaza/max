class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  belongs_to :album
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_one :featured, dependent: :destroy

  validates :name, presence: true
  validates :duration, presence: true, numericality: {
    only_integer: true, greater_than: 0 }

  validates_associated :featured, if: :featured?
  accepts_nested_attributes_for :featured, update_only: true

  validates :artist, absence: true, if: :has_album?
  validates :album, absence: true, if: :has_artist?

  def featured?
    featured.present?
  end
  def has_album?
    album.present?
  end
  def has_artist?
    artist.present?
  end
  def show_artist
    return album.artist if has_album?
    artist
  end

  private
  # To avoid confusions and get always the proper artist
  def artist
    super
  end
end
