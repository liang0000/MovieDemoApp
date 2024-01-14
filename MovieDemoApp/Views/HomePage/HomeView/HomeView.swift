import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(viewModel.movies, id: \.imdbID) { movie in
                        Button(action: {
                            viewModel.selectedPoster = movie
                        }, label: {
                            VStack(spacing: 0) {
                                MovieRemoteImage(urlString: movie.Poster)
                                    .scaledToFit()
                                
                                VStack(alignment: .leading) {
                                    Text(movie.Title)
                                        .font(.subheadline.bold())
                                        .lineLimit(1)
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
            .onAppear { viewModel.getMovies() }
            
            if viewModel.isLoading { LoadingView() }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .sheet(item: $viewModel.selectedPoster) { movie in
            PosterDetailView(movieID: movie.imdbID)
        }
    }
}

#Preview {
    HomeView()
}
