//
//  WeatherInfo.swift
//  Weather101
//
//  Created by Mac on 2022/01/03.
//

import Foundation

struct WeatherInfo: Codable {
    let weather: [Weather]
    let temparature: Temparature
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temparature = "main"
        case cityName = "name"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temparature: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
