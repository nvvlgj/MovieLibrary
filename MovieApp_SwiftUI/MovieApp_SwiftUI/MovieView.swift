import SwiftUI
import URLImage

struct MovieView: View {
    let movieModel: MoviesModel
    
    var body: some View {
        VStack {
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
                })
            }
            Text(movieModel.title)
        }
    }
}
