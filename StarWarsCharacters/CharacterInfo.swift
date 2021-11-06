//
//  Character.swift
//  StarWarsCharacters
//
//  Created by yc on 2021/11/04.
//

import Foundation

struct CharacterInfoList: Codable {
    let results: [CharacterInfo]
}

struct CharacterInfo: Codable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    //    let films: [String]
    //    let species: [String]
    //    let vehicles: [Vehicle]
    //    let starships: [String]
    //    var films = "films 준비중"
    //    var species = "species 준비중"
    //    var vehicles = "vehicles 준비중"
    //    var starships = "starships 준비중"
    
}

struct Homeworld: Codable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
}

//struct Vehicle: Codable {
//    let name: String
//    let model: String
//    let manufacturer: String
//    let cost_in_credits: String
//    let length: String
//    let max_atmosphering_speed: String
//    let crew: String
//    let passengers: String
//    let cargo_capacity: String
//    let consumables: String
//    let vehicle_class: String
//    let pilots: [String]
//    let films: [String]
//
//}
