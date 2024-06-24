class Review < ApplicationRecord
  belongs_to :movie

  after_save :update_movie_average_rating_cache
  after_destroy :update_movie_average_rating_cache

  private

  def update_movie_average_rating_cache
    movie.update_average_rating_cache
  end
end
