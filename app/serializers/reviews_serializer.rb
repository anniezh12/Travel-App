class ReviewsSerializer < ActiveModel::Serializer
  attributes :id,:comment,:ratings
  belongs_to :location
end
