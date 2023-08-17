import Foundation

/// Model to store data from JSON file.
struct MoviesModel: Codable, Identifiable, Hashable {

    var id: String
    var title: String
    var year: String
    var directors: [String]
    var directorsString: String
    var actors: [String]
    var actorsString: String
    var languages: String
    var genre: [String]
    var genresString: String
    var poster: URL?
    var plot: String
    var released: String
    var ratings: [Rating]
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case directors = "Director"
        case actors = "Actors"
        case languages = "Language"
        case genre = "Genre"
        case poster = "Poster"
        case plot = "Plot"
        case released = "Released"
        case ratings = "Ratings"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try values.decode(String.self, forKey: .title)
        self.year = try values.decode(String.self, forKey: .year)
        self.id = try values.decode(String.self, forKey: .id)
        self.languages = try values.decode(String.self, forKey: .languages)
        self.plot = try values.decode(String.self, forKey: .plot)
        self.released = try values.decode(String.self, forKey: .released)
        self.ratings = try values.decode([Rating].self, forKey: .ratings)
        
        self.directorsString = try values.decode(String.self, forKey: .directors)
        self.directors = directorsString.split(separator: ", ").map { String($0) }
        
        self.actorsString = try values.decode(String.self, forKey: .actors)
        self.actors = actorsString.split(separator: ", ").map { String($0) }
        
        self.genresString = try values.decode(String.self, forKey: .genre)
        self.genre = genresString.split(separator: ", ").map { String($0) }
        
        let posterString = try values.decode(String.self, forKey: .poster)
        self.poster = URL(string: posterString)
    }
    
    struct Rating: Codable, Identifiable, Hashable {
        var id: String
        var source: String
        var value: String
        
        enum CodingKeys: String, CodingKey {
            case source = "Source"
            case value = "Value"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try values.decode(String.self, forKey: .source)
            self.source = try values.decode(String.self, forKey: .source)
            self.value = try values.decode(String.self, forKey: .value)
        }
    }
}

/// Model used to display MovieModel in the form of a List.
struct MovieCategory: Identifiable {
    var id: String
    var name: String
    var items: [MovieCategory]?
    var movie: MoviesModel?
}
