class Featured < ActiveRecord::Base
  belongs_to :art
  belongs_to :song

  validates :art, presence: true
  validates :song, presence: true, on: :update
end
