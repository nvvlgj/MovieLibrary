import SwiftUI
import URLImage

/// Image view to download and display movie poster.
struct MoviePosterView: View {
    let url: URL?
    
    var body: some View {
        if let posterURL = url {
            URLImage(posterURL,
                     inProgress: { progress in
                Image(systemName: "circle.dotted")
            },
                     failure: { error, retry in
                Image(systemName: "exclamationmark.triangle")
            },
                     content: { image, info in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            })
        } else {
            Image(systemName: "exclamationmark.triangle")
        }
    }
}
