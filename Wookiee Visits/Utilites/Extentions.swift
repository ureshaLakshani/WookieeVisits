//
//  Extentions.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-27.
//

import Foundation

extension URL {
    
    func appending(_ queryItem: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}


enum RequestError: Error {
    case noDataAvalalible
    case invalidateURL
    case canNotProcessData
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .invalidateURL:
                return NSLocalizedString("Invalid URL!.", comment: "Request Error")
            case .noDataAvalalible:
                return NSLocalizedString("No data Avalalible!", comment: "Request Error")
            case .canNotProcessData:
                return NSLocalizedString("Can Not Process Data!.", comment: "Request Error")
            
        }
    }
}
