class SpotSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  has_many :reviews

  attributes :id, :title, :description, :images, :price

  def images
    return unless object.images.attached?
    object.images.map do |image|
      image.blob.attributes
        .slice('filename', 'byte_size', 'id')
        .merge(url: spot_image_url(image))
    end
  end

  def spot_image_url(image)
    url_for(image)
  end
end