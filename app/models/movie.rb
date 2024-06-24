class Movie < ApplicationRecord
  belongs_to :director
  has_many :movies_actors
  has_many :actors, through: :movies_actors
  has_many :movies_locations
  has_many :locations, through: :movies_locations
  has_many :reviews

  # Update average rating cache when a review is created, updated, or destroyed
  after_save :update_average_rating_cache
  after_destroy :update_average_rating_cache

  def self.search_by_actor(actor_name)
    joins(:actors).where('LOWER(actors.name) LIKE ?', "%#{actor_name.downcase}%")
  end

  def self.sorted_by_cached_average_rating
    all.sort_by { |movie| -movie.cached_average_rating.to_f }
  end

  def cached_average_rating
    Rails.cache.fetch("movies/#{id}/average_rating") { average_rating }
  end

  def update_average_rating_cache
    Rails.cache.write("movies/#{id}/average_rating", average_rating)
  end

  private

  def average_rating
    reviews.average(:stars)
  end
end
