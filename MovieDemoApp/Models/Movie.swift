import Foundation

struct Movie: Hashable, Codable, Identifiable {
    let imdbID: String
    let Title: String
    let Year: String
    let Poster: String
    var id: String { imdbID }
}

struct MovieDetail: Hashable, Codable {
    let imdbID: String
    let Title: String
    let DVD: String
    let Poster: String
    let Runtime: String
    let Director: String
    let Actors: String
    let Plot: String
    let Country: String
}

struct MovieResponse: Hashable, Codable {
    let Search: [Movie]
}
