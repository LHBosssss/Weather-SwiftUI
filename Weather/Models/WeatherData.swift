//
//  WeatherData.swift
//  Weather
//
//  Created by Ho Duy Luong on 4/12/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
}

struct Main: Codable {
    let temp: Float
    let temp_min: Float
    let temp_max: Float
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Wind: Codable {
    let speed: Float
    let deg: Int
}

struct Sys: Codable {
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

