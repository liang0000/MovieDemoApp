import UIKit

class NetworkManager: NSObject {
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    static let baseURL          = "https://www.omdbapi.com/"
    private let movieURL        = baseURL + "?apikey=8c4ba33d&s=avengers"
    private let movieDetailURL  = baseURL + "?apikey=8c4ba33d&i="
	let decoder					= JSONDecoder()
    
    private override init() {}
		
	func getMovies() async throws -> [Movie] {
        guard let url = URL(string: movieURL) else {
			throw MVError.invalidURL
        }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw MVError.invalidResponse
		}
		
		do {
			let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
			return decodedResponse.Search
		} catch {
			throw MVError.invalidData
		}
    }
    
	func getMovieDetail(id: String) async throws -> MovieDetail {
        guard let url = URL(string: movieDetailURL + id) else {
			throw MVError.invalidURL
        }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw MVError.invalidResponse
		}
		
		do {
			let decodedResponse = try decoder.decode(MovieDetail.self, from: data)
			return decodedResponse
		} catch {
			throw MVError.invalidData
		}
    }
    
	func downloadImage(from urlString: String) async -> UIImage? {
		let cacheKey = NSString(string: urlString)
		if let image = cache.object(forKey: cacheKey) { return image }
		
		guard let url = URL(string: urlString),
			  let (data, _) = try? await URLSession.shared.data(from: url),
			  let image = UIImage(data: data) else {
			return nil
		}
		
		cache.setObject(image, forKey: cacheKey)
		return image
    }
}
