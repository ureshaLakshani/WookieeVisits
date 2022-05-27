//
//  PlanetVM.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PlanetVM {
    
    //MARK: - Variables
    var isScrolling = true
    var page : Int = 1
    var next :  String?
    var planets = BehaviorRelay<[Planet]>(value: [])
    
    //API Call
    func getAllPlanets(completion : @escaping CompletionHandler ) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, "InternetConnectionOffline")
            return
        }
        /// get all planets  list
        NetworkManager.shared.getAllPlanets(page: page){ result in
            switch result{
                
            case .success(let planet):
                self.planets.accept(self.planets.value + (planet.results ?? []))
                self.next = planet.next
                completion(true, 200 , "success")
                
            case .failure(let error):
                completion(false, 978, error.localizedDescription)
                
            }
        }
    }}
