
import Foundation
func addMovieElement(_ movie: MovieElement) {
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        if !FileManager.default.fileExists(atPath: plistURL.path) {
            let initialMovieElements: [MovieElement] = []
            
            do {
                let encoder = PropertyListEncoder()
                encoder.outputFormat = .xml
                
                let initialData = try encoder.encode(initialMovieElements)
                try initialData.write(to: plistURL)
                print("Plist file created successfully.")
            } catch {
                print("Error creating plist file: \(error)")
                return
            }
        }
        
        do {
            let existingData = try Data(contentsOf: plistURL)
            
            var movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
            
            movieElements.append(movie)
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            
            let newData = try encoder.encode(movieElements)
            try newData.write(to: plistURL)
            print("MovieElement added successfully.")
        } catch {
            print("Error adding MovieElement: \(error)")
        }
    } else {
        print("Could not get documents directory.")
    }
}


func removeMovieElement(withTitle title: String) {
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        if FileManager.default.fileExists(atPath: plistURL.path) {
            do {
                let existingData = try Data(contentsOf: plistURL)
                
                var movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
                
                movieElements.removeAll { $0.title == title }
                
                let encoder = PropertyListEncoder()
                encoder.outputFormat = .xml
                
                let newData = try encoder.encode(movieElements)
                try newData.write(to: plistURL)
                print("MovieElement with title '\(title)' removed successfully.")
            } catch {
                print("Error removing MovieElement: \(error)")
            }
        } else {
            print("Plist file does not exist.")
        }
    } else {
        print("Could not get documents directory.")
    }
}

func readMovieElements() -> [MovieElement]? {
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        if FileManager.default.fileExists(atPath: plistURL.path) {
            do {
                let existingData = try Data(contentsOf: plistURL)
                
                let movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
                return movieElements
            } catch {
                print("Error reading MovieElements: \(error)")
                return nil
            }
        } else {
            print("Plist file does not exist.")
            return nil
        }
    } else {
        print("Could not get documents directory.")
        return nil
    }
}
func readMovieElements(byTitle : String) -> Bool? {
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        if FileManager.default.fileExists(atPath: plistURL.path) {
            do {
                let existingData = try Data(contentsOf: plistURL)
                
                let movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
                return movieElements.contains { movies in
                    movies.title == byTitle
                }
            } catch {
                print("Error reading MovieElements: \(error)")
                return nil
            }
        } else {
            print("Plist file does not exist.")
            return nil
        }
    } else {
        print("Could not get documents directory.")
        return nil
    }
}

