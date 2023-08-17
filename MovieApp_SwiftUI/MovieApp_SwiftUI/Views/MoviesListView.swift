import SwiftUI

/// List of movies separated in the form of categories.
struct MoviesListView: View {
    let categories = MovieDataManager.createMovieCategories()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            if searchText.count > 0 {
                MoviesSearchView(searchText: $searchText)
            } else {
                List(categories, children: \.items) { category in
                    // If the nested list contains a movie model, it means it is at its node.
                    // In that case, display a movie cell.
                    if let movieModel = category.movie {
                        NavigationLink(value: movieModel) {
                            MovieCellView(movieModel: movieModel)
                        }
                    }
                    
                    // If the category is "All movies", create a navigation link to open AllMoviesView.
                    else if category.id == MovieDataManager.allMoviesTitle {
                        NavigationLink(value: SortType.defaultSort) {
                            Text(category.name)
                        }.navigationDestination(for: SortType.self, destination: AllMoviesView.init)
                    }
                    
                    // If the list contains nested items, display its name.
                    else {
                        Text(category.name)
                    }
                }
                .navigationDestination(for: MoviesModel.self, destination: MovieDetailsView.init)
                .navigationTitle("Movies")
                
            }
        }.searchable(text: $searchText, prompt: "Search movies by title/actor/genre/director")
    }
}

// MARK: - Private subviews

/// Custom view that provides search functionality to MoviesListView.
private struct MoviesSearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        List(searchMovies(searchText: searchText)) { movieModel in
            NavigationLink(value: movieModel) {
                MovieCellView(movieModel: movieModel)
            }
        }.navigationDestination(for: MoviesModel.self, destination: MovieDetailsView.init)
    }
    
    func searchMovies(searchText: String) -> [MoviesModel] {
        return MovieDataManager.allMovies.filter {
            $0.title.contains(searchText)
            || $0.actors.contains { $0.contains(searchText) }
            || $0.directors.contains { $0.contains(searchText) }
            || $0.genre.contains { $0.contains(searchText) }
        }
    }
}
