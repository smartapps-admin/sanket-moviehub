
import Foundation


import Foundation

struct MovieElement: Codable {
    let title: String?
    let year: Int?
    let cast: [String]?
    let genres: [Genre]?
    let href: String?
    let extract: String?
    let thumbnail: String?
    let thumbnailWidth, thumbnailHeight: Int?

    enum CodingKeys: String, CodingKey {
        case title, year, cast, genres, href, extract, thumbnail
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
    }
}

enum Genre: String, Codable {
    case action = "Action"
    case adventure = "Adventure"
    case animated = "Animated"
    case biography = "Biography"
    case comedy = "Comedy"
    case crime = "Crime"
    case dance = "Dance"
    case disaster = "Disaster"
    case documentary = "Documentary"
    case drama = "Drama"
    case erotic = "Erotic"
    case family = "Family"
    case fantasy = "Fantasy"
    case foundFootage = "Found Footage"
    case historical = "Historical"
    case horror = "Horror"
    case independent = "Independent"
    case legal = "Legal"
    case liveAction = "Live Action"
    case martialArts = "Martial Arts"
    case musical = "Musical"
    case mystery = "Mystery"
    case noir = "Noir"
    case performance = "Performance"
    case political = "Political"
    case romance = "Romance"
    case satire = "Satire"
    case scienceFiction = "Science Fiction"
    case short = "Short"
    case silent = "Silent"
    case slasher = "Slasher"
    case sport = "Sport"
    case sports = "Sports"
    case spy = "Spy"
    case superhero = "Superhero"
    case supernatural = "Supernatural"
    case suspense = "Suspense"
    case teen = "Teen"
    case thriller = "Thriller"
    case war = "War"
    case western = "Western"
}

typealias Movie = [MovieElement]

func getMovies(Ofyear : Int) -> [MovieElement] {
    var moviesArray : [MovieElement] = []
    if let path = Bundle.main.path(forResource: "movies-\(Ofyear)s", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let myModelArray = try decoder.decode([MovieElement].self, from: data)
            moviesArray = myModelArray
            print("fetched succesfully \(Ofyear)")
        } catch {
            print("Error reading JSON file: \(error)")
        }
    } else {
        print("JSON file not found")
    }
return moviesArray
}
func getMovies() -> [MovieElement] {
    var moviesArray : [MovieElement] = []
    if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let myModelArray = try decoder.decode([MovieElement].self, from: data)
            moviesArray = myModelArray
            print("fetched succesfully ")
        } catch {
            print("Error reading JSON file: \(error)")
        }
    } else {
        print("JSON file not found")
    }
return moviesArray
}
func getMoviesGenres(forGenre genre: String) -> [MovieElement] {
    var moviesArray : [MovieElement] = []
    if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let myModelArray = try decoder.decode([MovieElement].self, from: data)
            moviesArray = myModelArray
            
            print("fetched succesfully")
        } catch {
            print("Error reading JSON file: \(error)")
        }
        let filteredMovies = moviesArray.filter { movie in
            if let genres = movie.genres, genres.contains(Genre(rawValue: genre) ?? .action) {
                return true
            } else {
                return false
            }
        }
        return filteredMovies
    }
    return moviesArray
}
