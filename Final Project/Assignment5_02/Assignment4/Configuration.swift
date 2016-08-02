//  Configuration.swift


import Foundation

class Configuration {
    var title : String = ""
    var contents = [(Int, Int)]()
    init(json: [String: AnyObject]) {
        // Initialization with JSON object - dictionary
        // Default title is ""
        title = json["title"] as? String ?? ""
        
        // Contents is an array of arrays, we parse it into tuple array
        if let points = json["contents"] as? [[Int]] {
            for point in points {
                if point.count == 2 {
                    contents.append((point[0], point[1]))
                }
            }
        }
    }
    init() {
        
    }
}