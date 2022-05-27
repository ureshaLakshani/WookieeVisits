//
//  Planet.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import Foundation
// MARK: - Plant
struct PlanetInfo: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Planet]?
}

// MARK: - Result
struct Planet: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
}
