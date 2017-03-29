class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs
  belongs_to :art

  validates :name, presence: true
  validates :artist, presence: true
end
