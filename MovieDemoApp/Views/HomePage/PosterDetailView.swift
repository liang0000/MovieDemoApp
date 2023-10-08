import SwiftUI

struct PosterDetailView: View {
    @Binding var movieID: String
    @EnvironmentObject var poster: ModelData
    var body: some View {
        VStack {
            ScrollView {
                AsyncImage(url: URL(string: poster.movieDetail.Poster)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
                }
                    //                .frame(maxWidth: 220)
                VStack {
                    Text(poster.movieDetail.Title)
                        .font(.title.bold())
                        Text("Director: ") +  Text(poster.movieDetail.Director).bold()
                    Text(poster.movieDetail.Plot)
                    
                    Text("Launch on ") + Text(poster.movieDetail.DVD).bold()
                }
            }
        }
        .task {
            do {
                try await getMovieDetail(movieID: movieID, poster: poster)
            } catch getError.invalidURL {
                print("invalidURL")
            } catch getError.invalidData {
                print("invalidData")
            } catch getError.invalidResponse {
                print("invalidResponse")
            } catch {
                print("unable to get anything")
            }
        }
    }
}

#Preview {
    PosterDetailView(movieID: .constant("tt2395427"))
        .environmentObject(ModelData())
}
