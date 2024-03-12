import UIKit

class NetworkManager: NSObject {
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    static let baseURL          = "https://www.omdbapi.com/"
    private let movieURL        = baseURL + "?apikey=8c4ba33d&s=avengers"
    private let movieDetailURL  = baseURL + "?apikey=8c4ba33d&i="
    
    private override init() {}
    
    func getMovies(completed: @escaping (Result<[Movie], MVError>) -> Void) {
        guard let url = URL(string: movieURL) else {
            completed(.failure(.invalidURL))
            return
        }
  
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
                completed(.success(decodedResponse.Search))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getMovieDetail(id: String, completed: @escaping (Result<MovieDetail, MVError>) -> Void) {
        guard let url = URL(string: movieDetailURL + id) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDetail.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
