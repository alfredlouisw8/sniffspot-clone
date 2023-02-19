class ReviewSerializer < ActiveModel::Serializer
  attributes :name, :comment, :point, :id
end