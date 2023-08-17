import SwiftUI

/// Individual cell of list representing a movie.
struct MovieCellView: View {
    let movieModel: MoviesModel
    
    var body: some View {
        HStack(spacing: 5) {
            MoviePosterView(url: movieModel.poster)
                .frame(width: 40, height: 40, alignment: .center)
            VStack(alignment: .leading, spacing: 10) {
                Text(movieModel.title).font(.caption)
                
                // A separate HStack is created for language so that the indentation of 2nd line
                // matches the beginning to languages list and not the "Language:" title.
                HStack(alignment: .top) {
                    Text("Language: ").font(.caption2)
                    Text(movieModel.languages).font(.caption2)
                }
                Text("Year: \(movieModel.year)").font(.caption2)
            }
        }
    }
}
