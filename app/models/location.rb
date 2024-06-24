class Location < ApplicationRecord
  has_many :movies_locations
  has_many :movies, through: :movies_locations
end
