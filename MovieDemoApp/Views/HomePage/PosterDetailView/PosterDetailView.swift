import SwiftUI

struct PosterDetailView: View {
    var movieID: String
    @Environment(\.dismiss) private var dismiss
    @State private var poster = PosterDetailViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                AsyncImage(url: URL(string: poster.movieDetail?.Poster ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("food-placeholder").resizable()
                }
                
                VStack {
                    Text(poster.movieDetail?.Title ?? "")
                        .font(.title.bold())
                        .onTapGesture { dismiss() }
                    Text("Director: ") + Text(poster.movieDetail?.Director ?? "").bold()
                    Text(poster.movieDetail?.Plot ?? "")
                    
                    Text("Launch on ") + Text(poster.movieDetail?.DVD ?? "").bold()
                }
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
