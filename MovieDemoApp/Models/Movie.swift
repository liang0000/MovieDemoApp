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

struct MockData {
    static let movies = [sampleMovie, sampleMovie, sampleMovie]
    
    static let sampleMovie = Movie(imdbID: "tt2455546", Title: "Avengers Assemble", Year: "2012–2019", Poster: "https://m.media-amazon.com/images/M/MV5BMTY0NTUyMDQwOV5BMl5BanBnXkFtZTgwNjAwMTA0MDE@._V1_SX300.jpg")
    
    static let sampleMovieDetail = MovieDetail(imdbID: "tt2395427", Title: "Avengers: Age of Ultron", DVD: "08 Sep 2015", Poster: "https://m.media-amazon.com/images/M/MV5BMTM4OGJmNWMtOTM4Ni00NTE3LTg3MDItZmQxYjc4N2JhNmUxXkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_SX300.jpg", Runtime: "141 min", Director: "Joss Whedon", Actors: "Robert Downey Jr., Chris Evans, Mark Ruffalo", Plot: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.", Country: "United States")
}
