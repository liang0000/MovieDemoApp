import Observation
import SwiftUI

@Observable
final class HomeViewModel {
    var movies: [Movie] = []
    var isLoading = false
    var alertItem: AlertItem?
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    func getMovies() {
        isLoading = true
		Task {
			do {
				let movies = try await NetworkManager.shared.getMovies()
				self.movies = movies
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
