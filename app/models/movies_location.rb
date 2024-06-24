class MoviesLocation < ApplicationRecord
  belongs_to :movie
  belongs_to :location
end
