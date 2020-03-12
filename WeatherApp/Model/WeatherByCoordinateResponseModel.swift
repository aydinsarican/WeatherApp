//
//  WeatherByCoordinateResponseModel.swift
//  WeatherApp
//
//  Created by Aydın Sarıcan on 10.03.2020.
//  Copyright © 2020 Aydın Sarıcan. All rights reserved.
//

//   let weatherResponseModel = try? newJSONDecoder().decode(WeatherResponseModel.self, from: jsonData)

//import Foundation

// MARK: - WeatherResponseModel
//struct WeatherResponseModel: Codable {
//    let coord: Coord
//    let weather: [Weather]
//    let base: String
//    let main: Main
//    let wind: Wind
//    let clouds: Clouds
//    let dt: Int
//    let sys: Sys
//    let timezone, id: Int
//    let name: String
//    let cod: Int
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - Coord
//struct Coord: Codable {
//    let lon, lat: Int
//}
//
//// MARK: - Main
//struct Main: Codable {
//    let temp, feelsLike, tempMin, tempMax: Double
//    let pressure, humidity: Int
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure, humidity
//    }
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let type, id: Int
//    let message: Double
//    let country: String
//    let sunrise, sunset: Int
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int
//    let main, weatherDescription, icon: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed, deg: Double
//}
