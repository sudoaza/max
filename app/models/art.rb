class Art < ActiveRecord::Base
  has_many :albums
  has_many :featureds

  has_attached_file :image,
      styles: { medium: ["300x300>", :png], thumb: ["100x100#", :png] }
  validates_attachment :image, presence: true,
      content_type: { content_type: /\Aimage/ },
      size: { less_than: 3.megabytes }
  validates_attachment_file_name :image, matches: [/png\z/, /jpe?g\z/, /gif\z/]
  validates :image_fingerprint, uniqueness: true, on: :create

  scope :by_id_or_fingerprint, ->(id_or_fingerprint) {
      find_by(id: id_or_fingerprint.to_i, image_fingerprint: id_or_fingerprint ) }
end
