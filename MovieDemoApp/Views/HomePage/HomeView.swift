import SwiftUI

struct HomeView: View {
    @EnvironmentObject var movie: ModelData
    
    private let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    @State var selectedPoster: String = ""
    @State var isSelectedPoster: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(movie.movies, id: \.self) { movie in
                    Button(action: {
                        isSelectedPoster.toggle()
                        selectedPoster = movie.imdbID
                    }, label: {
                        VStack(spacing: 0) {
                            AsyncImage(url: URL(string: movie.Poster)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Rectangle())
                            } placeholder: {
                                Rectangle()
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: 220)
                            
                            VStack(alignment: .leading) {
                                Text(movie.Title)
                                    .font(.subheadline.bold())
                                Text(movie.Year)
                                    .font(.caption)
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            .padding(10)
                            .foregroundStyle(.black)
                            .background(.white)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                }
            }
            .padding()
        }
        .refreshable {}
        .background(.gray.opacity(0.3))
        .task {
            do {
                try await getMovie(movie: movie)
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
        .sheet(isPresented: $isSelectedPoster) {
            PosterDetailView(movieID: $selectedPoster)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ModelData())
}
