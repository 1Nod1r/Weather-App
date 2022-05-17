//
//  Model.swift
//  Weather App
//
//  Created by Nodirbek on 17/05/22.
//

import Foundation

struct WeatherData: Codable {
    let city: City
    let list: [List]
    var name: String {
        return city.name
    }
    
    var country: String {
        return city.country
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
}

struct List: Codable {
    let dt: Int
    let humidity: Double
    let pressure: Double
    let temp: Temp
}

struct Temp: Codable {
    let average: Double
}
