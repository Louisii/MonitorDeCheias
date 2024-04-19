//
//  ForecastData.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 18/04/24.
//

import Foundation


import Foundation

struct ForecastData: Codable, Hashable {
   
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [ListItem]?
    let city: City?
}


struct Main: Codable, Hashable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    let humidity: Int?
    let tempKf: Double?
}

struct Weather: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable, Hashable {
    let all: Int?
}

struct Wind: Codable, Hashable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct Rain: Codable, Hashable {
    let threeH: Double?
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct Sys: Codable, Hashable {
    let pod: String?
}

struct ListItem: Codable, Hashable {
    let dt: Int
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct City: Codable, Hashable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}

struct Coord: Codable, Hashable {
    let lat: Double?
    let lon: Double?
}
