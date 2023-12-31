import Foundation
import Observation
import SwiftUI

@Observable
final class HomeViewModel {
    var movies: [Movie] = []
    var isLoading = false
    var alertItem: AlertItem?
    var selectedPoster: Movie?
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    
    func getMovies() {
        isLoading = true
        
        NetworkManager.shared.getMovies { [self] result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                
                switch result {
                    case .success(let movies):
                        self.movies = movies
                        
                    case .failure(let error):
                        switch error {
                            case .invalidData:
                                alertItem = AlertContext.invalidData
                                
                            case .invalidURL:
                                alertItem = AlertContext.invalidURL
                                
                            case .invalidResponse:
                                alertItem = AlertContext.invalidResponse
                                
                            case .unableToComplete:
                                alertItem = AlertContext.unableToComplete
                        }
                }
            }
        }
    }
}
