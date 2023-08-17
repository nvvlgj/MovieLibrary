import Foundation

class MovieDataManager {
    
    static let yearTitle = "Year"
    static let genreTitle = "Genre"
    static let directorsTitle = "Directors"
    static let actorsTitle = "Actors"
    static let allMoviesTitle = "All Movies"
    
    static var allMovies: [MoviesModel] = []
    
    static func createMovieCategories() -> [MovieCategory] {
        Self.allMovies = MovieDataManager.parseMovieDatabaseJSON() ?? []
        
        // Create Years category.
        let years = allMovies.compactMap { $0.year }.removingDuplicates().map { year in
            let filteredMovies = allMovies.filter { $0.year == year }.map {
                MovieCategory(id: $0.id, name: $0.title, movie: $0)
            }
            return MovieCategory(id: year, name: year, items: filteredMovies)
        }
        let yearsCategory = MovieCategory(id: Self.yearTitle, name: Self.yearTitle, items: years)
        
        // Create Genre category.
        let genre = allMovies.flatMap { $0.genre }.removingDuplicates().map { genreName in
            let filteredMovies = allMovies.filter { $0.genre.contains([genreName]) }.map {
                MovieCategory(id: $0.id, name: $0.title, movie: $0)
            }
            return MovieCategory(id: genreName, name: genreName, items: filteredMovies)
        }
        let genreCategory = MovieCategory(id: Self.genreTitle, name: Self.genreTitle, items: genre)
        
        // Create Directors category.
        let directors = allMovies.flatMap { $0.directors }.removingDuplicates().map { directorName in
            let filteredMovies = allMovies.filter { $0.directors.contains([directorName]) }.map {
                MovieCategory(id: $0.id, name: $0.title, movie: $0)
            }
            return MovieCategory(id: directorName, name: directorName, items: filteredMovies)
        }
        let directorsCategory = MovieCategory(id: Self.directorsTitle, name: Self.directorsTitle, items: directors)
        
        // Create Actors category.
        let actors = allMovies.flatMap { $0.actors }.removingDuplicates().map { actorName in
            let filteredMovies = allMovies.filter { $0.actors.contains([actorName]) }.map {
                MovieCategory(id: $0.id, name: $0.title, movie: $0)
            }
            return MovieCategory(id: actorName, name: actorName, items: filteredMovies)
        }
        let actorsCategory = MovieCategory(id: Self.actorsTitle, name: Self.actorsTitle, items: actors)
        
        let allMoviesCategory = MovieCategory(id: Self.allMoviesTitle, name: Self.allMoviesTitle)
        return [yearsCategory, genreCategory, directorsCategory, actorsCategory, allMoviesCategory]
    }
    
    // MARK: - Private Helpers
    
    private static func parseMovieDatabaseJSON() -> [MoviesModel]? {
        guard let filePath = Bundle.main.path(forResource: "movies", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(filePath: filePath)) else {
            return nil
        }
        
        do {
            let moviesModel = try JSONDecoder().decode([MoviesModel].self, from: jsonData)
            return moviesModel
        } catch {
            print(error)
            return nil
        }
    }
}

// MARK: - Private Extensions

/// Extenssion to remove duplicate elements from an Array
extension Array where Element: Hashable {
    
    // Remove duplicates in an Array.
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}
