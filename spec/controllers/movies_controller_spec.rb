require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    let!(:director) { create(:director) }
    let!(:actor1) { create(:actor, name: 'Leonardo DiCaprio') }
    let!(:actor2) { create(:actor, name: 'Brad Pitt') }
    let!(:movie1) { create(:movie, title: 'Movie 1', director: director) }
    let!(:movie2) { create(:movie, title: 'Movie 2', director: director) }
    let!(:movie3) { create(:movie, title: 'Movie 3', director: director) }

    before do
      movie1.actors << actor1
      movie2.actors << actor2
      movie3.actors << actor1

      create(:review, movie: movie1, stars: 3)
      create(:review, movie: movie2, stars: 2)
      create(:review, movie: movie3, stars: 5)

      movie1.update_average_rating_cache
      movie2.update_average_rating_cache
      movie3.update_average_rating_cache
    end

    context 'when search query is present' do
      it 'filters movies by actor name and sorts by cached average rating' do
        get :index, params: { search: 'Leonardo' }

        expect(assigns(:movies)).to match_array([movie3, movie1])
      end
    end

    context 'when search query is not present' do
      it 'retrieves all movies and sorts by cached average rating' do
        get :index

        expect(assigns(:movies)).to match_array([movie3, movie1, movie2])
      end
    end
  end
end
