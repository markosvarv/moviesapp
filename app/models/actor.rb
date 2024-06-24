class Actor < ApplicationRecord
  has_many :movies_actors
  has_many :movies, through: :movies_actors
end
