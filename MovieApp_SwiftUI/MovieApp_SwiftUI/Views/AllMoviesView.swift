import SwiftUI

/// Types of sort available in AllMoviesView.
enum SortType: String {
    case defaultSort = "default"
    case alphabetical = "alphabetical"
    case year = "year"
}

/// View displaying all movies.
struct AllMoviesView: View {
    
    let movieModels: [MoviesModel] = MovieDataManager.allMovies
    @State var sortSelection: SortType = .defaultSort
    
    var body: some View {
        AllMoviesSortView(sortSelection: $sortSelection)
        
        // List view to display all movies.
        List(sortedMovies()) { movieModel in
            NavigationLink(value: movieModel) {
                MovieCellView(movieModel: movieModel)
            }
        }
        .navigationDestination(for: MoviesModel.self, destination: MovieDetailsView.init)
        .navigationTitle("All Movies")
    }
    
    // Sort movies based on title or year.
    func sortedMovies() -> [MoviesModel] {
        switch(sortSelection) {
        case .defaultSort:
            return movieModels
        case .alphabetical:
            return movieModels.sorted { $0.title < $1.title }
        case .year:
            return movieModels.sorted { $0.year < $1.year }
        }
    }
}

// MARK: - Private subviews

/// Sort view to decide sorting of all movies list.
private struct AllMoviesSortView: View {
    @Binding var sortSelection: SortType
    
    var body: some View {
        Picker("Sort", selection: $sortSelection) {
            Text("Default").tag(SortType.defaultSort)
            Text("Alphabetical").tag(SortType.alphabetical)
            Text("Year").tag(SortType.year)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}
