require 'csv'

CSV_MOVIES_PATH = 'lib/movies.csv'
CSV_REVIEWS_PATH = 'lib/reviews.csv'

namespace :import do
  desc "Import movies, actors, locations, and reviews from CSV files"
  task movies_directors_actors_locations_reviews: :environment do
    # Import movies, directors, actors, and locations from movies.csv
    CSV.foreach(CSV_MOVIES_PATH, headers: true) do |row|
      
      # Ensure directors are unique
      director = Director.find_or_create_by(name: row['Director'])

      movie = Movie.find_or_create_by!(
        title: row['Movie'],
        description: row['Description'],
        year: row['Year'],
        director: director
      )

      # Ensure actors are unique and associated with the movie
      actor = Actor.find_or_create_by(name: row['Actor'])
      movie.actors << actor unless movie.actors.include?(actor)

      # Ensure locations are unique and associated with the movie
      location = Location.find_or_create_by(name: row['Filming location'], country: row['Country'])
      movie.locations << location unless movie.locations.include?(location)
    end

    # Import reviews from reviews.csv
    CSV.foreach(CSV_REVIEWS_PATH, headers: true) do |row|
      movie = Movie.find_by(title: row['Movie'])
      if movie
        Review.find_or_create_by!(
          movie: movie,
          user: row['User'],
          stars: row['Stars'],
          review: row['Review']
        )
      else
        puts "Movie not found for review: #{row['Movie']}"
      end
    end

    puts "Import finished!"
  end
end
