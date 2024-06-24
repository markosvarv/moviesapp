require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:director) { create(:director) }
  let(:movie) { create(:movie, director: director) }

  describe 'average_rating' do
    it 'calculates the average rating of reviews' do
      create(:review, movie: movie, stars: 5)
      create(:review, movie: movie, stars: 3)

      expect(movie.send(:average_rating)).to eq(4.0)
    end
  end

  describe 'cached_average_rating' do
    it 'returns the cached average rating' do
      allow(Rails.cache).to receive(:fetch).and_return(4.0)

      expect(movie.cached_average_rating).to eq(4.0)
    end
  end

  describe 'search_by_actor' do
    it 'returns movies matching the actor name' do
      actor = create(:actor, name: 'Leonardo DiCaprio')
      movie.actors << actor

      result = Movie.search_by_actor('leonardo')

      expect(result).to include(movie)
    end
  end
end
