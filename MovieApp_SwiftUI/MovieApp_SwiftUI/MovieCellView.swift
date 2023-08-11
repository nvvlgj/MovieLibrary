import SwiftUI
import URLImage

struct MovieCellView: View {
    let movieModel: MoviesModel
    
    var body: some View {
        HStack(spacing: 5) {
            if let posterURL = movieModel.poster {
                URLImage(posterURL,
                         inProgress: { progress in
                    Image(systemName: "photo")
                },
                         failure: { error, retry in
                    Text("Failed")
                },
                         content: { image, info in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                })
            }
            VStack(spacing: 10) {
                Text(movieModel.title).font(.caption)
                Text("Year: \(movieModel.year)").font(.caption2)
            }
        }
    }
}
