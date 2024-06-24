# MoviesApp
MoviesApp is a Ruby on Rails application for managing movies, directors, actors, locations, and reviews.
## Installation
1. Clone the repository:
   ```
   git clone https://github.com/markosvarv/moviesapp
   ```
2. Go to the app directory
   ```
   cd moviesapp
   ```
3. Install dependencies:
	```
   bundle install
	```
4. Setup the database:
   ```
   rails db:create
   rails db:migrate
   ```
5. Run the task to import both CSV files:
   ```
   rails import:movies_directors_actors_locations_reviews
   ```
6. Run the server:
   ```
   rails server
   ```
7. Access the application:
   Open your web browser and go to http://localhost:3000 to view the MoviesApp.

## Run the tests
   ```
   bundle exec rspec
   ```

## Design Choices
1. The application uses the default Rails database, *SQLite*, for ease of creation and testing.
2. Each movie has only one director, as assumed from the CSV file data.
3. Given the small size of the current codebase, the logic is kept within the model and controller for simplicity. However, as the application grows, it might benefit from adopting design patterns such as repositories or query objects for database access and service objects for controller logic. These patterns can enhance maintainability and scalability, making them valuable as the application's complexity grows.

## Models
### Movie
Represents a movie with attributes like title, description, year, etc.
Has associations with Director, Actors, Locations, and Reviews.
Includes **caching** of average ratings for performance.
### Director
Represents a director with a name attribute.
Associated with movies through the *belongs_to* association.
### Actor
Represents an actor with a name attribute.
Associated with movies through the *has_many :through* association.
### Location
Represents a filming location with name and country attributes.
Associated with movies through the *has_many :through* association.
### Review
Represents a review for a movie with attributes like stars and comments.
Associated with movies through the *belongs_to* association.
