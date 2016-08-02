//  NetworkService.swift


import Foundation

// Exception type for JSON parsing
enum JSONError: String, ErrorType {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}


class NetworkService: NSObject {
    static let sharedInstance = NetworkService()
    
    // This method encapsulates the data fetching and parsing
    // success and failure closures make this function easy to use
    func getConfigurations(urlPath: String, success: (configurations: [Configuration])-> Void, failure: (error: NSError)->Void) {
        
        guard let endpoint = NSURL(string: urlPath) else {
            failure(error: NSError(domain: "Error creating endpoint", code: 400, userInfo: nil))
            return
        }
        let request = NSMutableURLRequest(URL:endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            do {
                // Is there any data?
                guard let data = data else {
                    throw JSONError.NoData
                }
                // Is the data parsable?
                guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray else {
                    throw JSONError.ConversionFailed
                }
                var configurations = [Configuration]()
                for jsonItem in json {
                    if let jsonItem = jsonItem as? [String : AnyObject] {
                        configurations.append(Configuration(json: jsonItem))
                    }
                }
                success(configurations: configurations)
            } catch let error as JSONError {
                failure(error: NSError(domain: error.rawValue, code: 404, userInfo: nil))
            } catch let error as NSError {
                failure(error: error)
            }
            }.resume()
    }

}
