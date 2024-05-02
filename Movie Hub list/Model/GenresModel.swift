
import Foundation
import UIKit

typealias Genres = [String]

func getGenres() -> Genres {
    var moviesArray : Genres = Genres()
    if let path = Bundle.main.path(forResource: "genres", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let myModelArray = try? JSONDecoder().decode(Genres.self, from: data)
            moviesArray = myModelArray!
            print("fetched succesfully")
        } catch {
            print("Error reading JSON file: \(error)")
        }
    } else {
        print("JSON file not found")
    }
    return moviesArray
}
