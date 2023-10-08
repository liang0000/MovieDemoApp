import Foundation
import Combine

func getMovie(movie: ModelData) async throws {
    let apiKey = "8c4ba33d"
    let search = "avengers"
    let endpoint = "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(search)"
    
    guard let url = URL(string: endpoint) else {
        throw getError.invalidURL
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
            throw getError.invalidData
        }
        
        movie.movies = returned.Search
    } catch {
        throw getError.invalidData
    }
}

func getMovieDetail(movieID: String, poster: ModelData) async throws {
    let apiKey = "8c4ba33d"
    let endpoint = "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(movieID)"
    
    guard let url = URL(string: endpoint) else {
        throw getError.invalidURL
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let returned = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
            throw getError.invalidData
        }
        
        poster.movieDetail = returned
    } catch {
        throw getError.invalidData
    }
}

enum getError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

    // http://www.omdbapi.com/?apikey=8c4ba33d&s=avengers
    // http://www.omdbapi.com/?apikey=8c4ba33d&i=tt2395427
