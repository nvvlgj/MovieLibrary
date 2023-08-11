import Foundation

struct MoviesModel: Codable, Identifiable, Hashable {
    var title: String
    var year: String
    var directors: [String]
    var actors: [String]
    var languages: [String]
    var genre: [String]
    var poster: URL?
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case directors = "Director"
        case actors = "Actors"
        case languages = "Language"
        case genre = "Genre"
        case poster = "Poster"
        case id = "imdbID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try values.decode(String.self, forKey: .title)
        self.year = try values.decode(String.self, forKey: .year)
        self.id = try values.decode(String.self, forKey: .id)
        
        let directorsString = try values.decode(String.self, forKey: .directors)
        self.directors = directorsString.split(separator: ", ").map { String($0) }
        
        let actorsString = try values.decode(String.self, forKey: .actors)
        self.actors = actorsString.split(separator: ", ").map { String($0) }
        
        let languagesString = try values.decode(String.self, forKey: .languages)
        self.languages = languagesString.split(separator: ", ").map { String($0) }
        
        let genresString = try values.decode(String.self, forKey: .genre)
        self.genre = genresString.split(separator: ", ").map { String($0) }
        
        let posterString = try values.decode(String.self, forKey: .poster)
        self.poster = URL(string: posterString)
    }
}

struct Section: Identifiable {
    var id: String
    var name: String
    var items: [Section]?
    var movie: MoviesModel?
}

