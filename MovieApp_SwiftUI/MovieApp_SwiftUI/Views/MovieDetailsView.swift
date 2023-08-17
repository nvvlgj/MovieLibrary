import SwiftUI
import URLImage

/// View dedicated to display all details of a movie.
struct MovieDetailsView: View {
    let movieModel: MoviesModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 7) {
                MoviePosterView(url: movieModel.poster)
                    .frame(width: 200, height: 200, alignment: .center)
                Text(movieModel.title).font(.title2)
                Text(movieModel.plot).font(.caption)
                
                // Display other details in a tabular form with a divider in between.
                Divider()
                MovieDetailsRow(
                    leadingText: "Cast & Crew",
                    trailingText: movieModel.actorsString + "\n" + movieModel.directorsString)
                MovieDetailsRow(leadingText: "Release Date", trailingText: movieModel.released)
                MovieDetailsRow(leadingText: "Genre", trailingText: movieModel.genresString)
                MovieRatingView(ratings: movieModel.ratings)
                Divider()
            }
        }
        .padding()
    }
}

// MARK: - Private subviews

///  Custom view to display movie rating based on source selection.
private struct MovieRatingView: View {
    let ratings: [MoviesModel.Rating]
    @State private var ratingIndex = 0
    
    var body: some View {
        HStack {
            Menu {
                Picker("Rating", selection: $ratingIndex) {
                    ForEach(0..<ratings.count, id: \.self) {
                        Text(ratings[$0].source)
                    }
                }
            } label: {
                Text(ratings[ratingIndex].source).font(.caption)
            }
            Spacer()
            Text(ratings[ratingIndex].value).font(.caption)
        }
    }
}

/// Reusable view to display movie details in a tabular form.
private struct MovieDetailsRow: View {
    let leadingText: String
    let trailingText: String
    
    var body: some View {
        VStack {
            HStack {
                Text(leadingText).font(.caption)
                Spacer()
                Text(trailingText).font(.caption)
            }
            Divider()
        }
    }
}
