class LocationSerializer < ActiveModel::Serializer
  attributes :id,:name,:description,:location,:img_url
  has_many :reviews
end
