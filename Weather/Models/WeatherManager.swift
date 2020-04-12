//
//  WeatherManager.swift
//  Weather
//
//  Created by Ho Duy Luong on 4/12/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation

class WeatherManager: ObservableObject {
    
    @Published var weatherData = WeatherModel(n: "", t: 0.0, ht: 0.0, lt: 0.0, hu: 1, cid: 100, des: "", ws: 0.0, wd: 1, sr: 0, ss: 0)
    
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey: String = "d1762fbfe612dca92c859807b7fc6183"
    let units: String = "metric"
    
    func fetchData(cityName: String) -> Void {
        let urlString = "\(baseURL)?appid=\(apiKey)&units=\(units)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(weatherData)
    }
    
    func performRequest(urlString: String) -> Void {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("task error: \(error)")
                    return
                }
                
                if let safeData = data{
                    print("URL = \(url)")
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.weatherData = weather
                            
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let highTemp = decodedData.main.temp_max
            let lowTemp = decodedData.main.temp_min
            let humidity = decodedData.main.humidity
            let conID = decodedData.weather[0].id
            let des = decodedData.weather[0].description
            let windSpeed = decodedData.wind.speed
            let windDeg = decodedData.wind.deg
            let sunrise = decodedData.sys.sunrise
            let sunset = decodedData.sys.sunset
            let weather = WeatherModel(n: name, t: temp, ht: highTemp, lt: lowTemp, hu: humidity, cid: conID, des: des, ws: windSpeed, wd: windDeg, sr: sunrise, ss: sunset)
            return weather
        } catch {
            print("Parse error \(error)")
            return nil
        }
    }
    
    
}
