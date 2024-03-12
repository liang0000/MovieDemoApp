import SwiftUI

struct PosterDetailView: View {
    var movieID: String
    @State private var poster = PosterDetailViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                AsyncImage(url: URL(string: poster.movieDetail?.Poster ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
				VStack {
                    Text(poster.movieDetail?.Title ?? "")
                        .font(.title.bold())
                    Text("Director: ") + Text(poster.movieDetail?.Director ?? "").bold()
                    Text(poster.movieDetail?.Plot ?? "")
						.multilineTextAlignment(.center)
                    Text("Launch on ") + Text(poster.movieDetail?.DVD ?? "").bold()
                }
				.padding(.horizontal)
				.padding(.bottom)
            }
            
            if poster.isLoading { LoadingView() }
        }
        .onAppear { poster.getMovieDetail(id: movieID) }
        .alert(item: $poster.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    PosterDetailView(movieID: "tt2395427")
}
