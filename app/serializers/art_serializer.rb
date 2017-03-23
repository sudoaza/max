class ArtSerializer < ActiveModel::Serializer
  attributes :id, :image_fingerprint, :original, :medium, :thumb

  def original
    object.image.url
  end
  def medium
    object.image.url :medium
  end
  def thumb
    object.image.url :thumb
  end
end
