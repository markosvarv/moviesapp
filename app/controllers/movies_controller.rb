class MoviesController < ApplicationController
  def index
    if params[:search].present?
      @movies = Movie.search_by_actor(params[:search])
    else
      @movies = Movie.all
    end
  
    # Always sort by average rating
    @movies = @movies.sorted_by_cached_average_rating
  end
end
