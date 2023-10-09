import Foundation
    //import SwiftData
import Observation

@Observable
class ModelData {
    var movies: [Movie] = []
    var movieDetail: MovieDetail = MovieDetail(imdbID: "", Title: "", DVD: "", Poster: "", Runtime: "", Director: "", Actors: "", Plot: "", Country: "")
}

    //@Model
struct Returned: Hashable, Codable {
    var Search: [Movie]
}

struct Movie: Hashable, Codable {
        //    @Attribute(.unique) let imdbID: String
    var imdbID: String
    var Title: String
    var Year: String
    var Poster: String
}

struct MovieDetail: Hashable, Codable {
    var imdbID: String
    var Title: String
    var DVD: String
    var Poster: String
    var Runtime: String
    var Director: String
    var Actors: String
    var Plot: String
    var Country: String
    
    init(imdbID: String, Title: String, DVD: String, Poster: String, Runtime: String, Director: String, Actors: String, Plot: String, Country: String) {
        self.imdbID = imdbID
        self.Title = Title
        self.DVD = DVD
        self.Poster = Poster
        self.Runtime = Runtime
        self.Director = Director
        self.Actors = Actors
        self.Plot = Plot
        self.Country = Country
    }
}
