//
//  NetworkManager.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import Foundation
import UIKit

class NetworkManager {
    
    public static let shared  = NetworkManager()
    private let session = URLSession.shared
    private let url = "https://swapi.dev/api/planets"
    
    private init(){}
    
    //network function
    func getAllPlanets(page : Int , completion : @escaping (Result<PlanetInfo, RequestError>) -> Void) {
        
        // check URL
        guard let url = URL(string: url) else {
            completion(.failure(.invalidateURL))
            return
        }
        
        let newUrl =  url.appending("page", value: "\(page)")
        let dataTask = session.dataTask(with: newUrl) { data, response, error in
            
            guard let resposeData = data else{
                completion(.failure(.noDataAvalalible))
                return
            }
            
            do{
                /// get PlanetInfo data after decode from json to PlanetInfo object
                /// Return :    PlanetInfo object
                let decoder = JSONDecoder()
                let planetResponse = try decoder.decode(PlanetInfo.self,
                                                        from : resposeData)
                completion(.success(planetResponse))
                
            }catch {
                completion(.failure(.canNotProcessData))
            }
        }
        //Resumes the task
        dataTask.resume()
    }
}


