//
//  WeatherModel.swift
//  Weather
//
//  Created by Ho Duy Luong on 4/12/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation

struct WeatherModel {
    let name: String
    let temp: Float
    let highTemp: Float
    let lowTemp: Float
    let humidity: Int
    let conditionID: Int
    var conditionName: String = ""
    let description: String
    let windSpeed: Float
    let windDeg: Int
    var sunrise = NSDate()
    var sunset = NSDate()

    init(n: String, t: Float, ht: Float, lt: Float, hu: Int, cid: Int, des: String, ws: Float, wd: Int, sr: TimeInterval, ss: TimeInterval) {
        self.name = n
        self.temp = t
        self.highTemp = ht
        self.lowTemp = lt
        self.humidity = hu
        self.conditionID = cid
        self.description = des
        self.windSpeed = ws
        self.windDeg = wd
        self.conditionName = getConditionName(weatherId: cid)
        self.sunrise = getDate(time: sr)
        self.sunset = getDate(time: ss)
    }
 
    func getDate(time: TimeInterval) -> NSDate {
        return NSDate(timeIntervalSince1970: time)
    }

    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
        case 200...202:
            return "cloud.bolt.rain"
        case 210...212:
            return "cloud.bolt"
        case 221...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.sun.rain"
        case 511:
            return "cloud.snow"
        case 520...531:
            return "cloud.heavyrain"
        case 600...602:
            return "cloud.snow"
        case 611...616:
            return "cloud.sleet"
        case 620...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 800...802:
            return "cloud"
        case 803...804:
            return "smoke"
        default:
            return "sun.max"
        }
    }
}

