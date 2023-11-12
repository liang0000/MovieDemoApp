import Foundation
import Observation

@Observable
final class PosterDetailViewModel {
    var movieDetail: MovieDetail?
    var isLoading = false
    var alertItem: AlertItem?
    
    func getMovieDetail(id: String) {
        isLoading = true
        
        NetworkManager.shared.getMovieDetail(id: id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                    case .success(let movieDetail):
                        self.movieDetail = movieDetail
                        
                    case .failure(let error):
                        switch error {
                            case .invalidData:
                                self.alertItem = AlertContext.invalidData
                                
                            case .invalidURL:
                                self.alertItem = AlertContext.invalidURL
                                
                            case .invalidResponse:
                                self.alertItem = AlertContext.invalidResponse
                                
                            case .unableToComplete:
                                self.alertItem = AlertContext.unableToComplete
                        }
                }
            }
        }
    }
}
