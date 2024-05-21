import Foundation
import Observation

@Observable
final class PosterDetailViewModel {
    var movieDetail: MovieDetail?
    var isLoading = false
    var alertItem: AlertItem?
    
    func getMovieDetail(id: String) {
        isLoading = true
		Task {
			do {
				let movieDetail = try await NetworkManager.shared.getMovieDetail(id: id)
				self.movieDetail = movieDetail
			} catch MVError.invalidData {
				alertItem = AlertContext.invalidData
			} catch MVError.invalidURL {
				alertItem = AlertContext.invalidURL
			} catch MVError.invalidResponse {
				alertItem = AlertContext.invalidResponse
			} catch {
				alertItem = AlertContext.unableToComplete
			}
			isLoading = false
		}
    }
}
