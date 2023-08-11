import Foundation

class JSONDataParser {
    
    static var allMovies: [MoviesModel] = []
    
    static func createMovieSections() -> [Section] {
        Self.allMovies = JSONDataParser.parseMovieDatabaseJSON() ?? []
        
        // Years
        let years = allMovies.compactMap { $0.year }.removingDuplicates().map { year in
            let filteredMovies = allMovies.filter { $0.year == year }.map {
                Section(id: $0.id, name: $0.title, movie: $0)
            }
            return Section(id: year, name: year, items: filteredMovies)
        }
        let yearsSection = Section(id: "Year", name: "Year", items: years)
        
        // Genre
        let genre = allMovies.flatMap { $0.genre }.removingDuplicates().map { genreName in
            let filteredMovies = allMovies.filter { $0.genre.contains([genreName]) }.map {
                Section(id: $0.id, name: $0.title, movie: $0)
            }
            return Section(id: genreName, name: genreName, items: filteredMovies)
        }
        let genreSection = Section(id: "Genre", name: "Genre", items: genre)
        
        // Directors
        let directors = allMovies.flatMap { $0.directors }.removingDuplicates().map { directorName in
            let filteredMovies = allMovies.filter { $0.directors.contains([directorName]) }.map {
                Section(id: $0.id, name: $0.title, movie: $0)
            }
            return Section(id: directorName, name: directorName, items: filteredMovies)
        }
        let directorsSection = Section(id: "Directors", name: "Directors", items: directors)
        
        // Actors
        let actors = allMovies.flatMap { $0.actors }.removingDuplicates().map { actorName in
            let filteredMovies = allMovies.filter { $0.actors.contains([actorName]) }.map {
                Section(id: $0.id, name: $0.title, movie: $0)
            }
            return Section(id: actorName, name: actorName, items: filteredMovies)
        }
        let actorsSection = Section(id: "Actors", name: "Actors", items: actors)
        
        let allMoviesNames = allMovies.flatMap { Section(id: $0.id, name: $0.title, movie: $0) }
        let allMoviesSection = Section(id: "All Movies", name: "All Movies", items: allMoviesNames)
        
        return [yearsSection, genreSection, directorsSection, actorsSection, allMoviesSection]
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

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
