import SwiftUI

struct MoviesListView: View {
    let items = JSONDataParser.createMovieSections()
    
    var body: some View {
        NavigationStack {
            List(items, children: \.items) { row in
                if let movieModel = row.movie {
                    NavigationLink(value: movieModel) {
                        MovieCellView(movieModel: movieModel)
                    }
                } else {
                    Text(row.name)
                }
            }
            .navigationDestination(for: MoviesModel.self, destination: MovieView.init)
            .navigationTitle("Movies")
        }
    }
}
