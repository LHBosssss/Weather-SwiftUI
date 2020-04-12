//
//  ContentView.swift
//  Weather
//
//  Created by Ho Duy Luong on 4/11/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var cityName: String = ""
    let city = "hanoi"
    @ObservedObject var Data = WeatherManager()
    var body: some View {
        ZStack {
            VStack(alignment: .trailing, spacing: 0) {
                
                //Location City Search
                HStack {
                    Button(action: {
                        print("Button")
                    }) {
                        Image(systemName: "location")
                            .font(.system(size: 30))
                    }
                    TextField("Enter City Name", text: $cityName)
                        .border(Color.black)
                        .padding(.all, 5)
                        .border(Color("weatherColor"), width: 2)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.trailing)
                    Button(action: {
                        
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 30))
                    }
                }
                .padding(.top, 5)
                
                // Weather Stack
                VStack(alignment: .trailing, spacing: 0) {
                    // City Name
                    Text(Data.weatherData.name.capitalized)
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                    // Weather Icon + Description
                    Image(systemName: Data.weatherData.conditionName)
                        //                    .resizable()
                        .frame(width: 150, height: 150, alignment: .trailing)
                        .font(.system(size: 100))
                    Text(Data.weatherData.description.capitalized)
                        .fontWeight(.thin)
                        .frame(width: 150)
                    // Temp
                    HStack( spacing: 0) {
                        Text(String(format: "%.0f", Data.weatherData.temp))
                            .font(.system(size: 50))
                        
                        Text("o")
                            .frame(height: 60, alignment: .top)
                            .font(.system(size: 20))
                        Text("C")
                            .font(.system(size: 62))
                            .fontWeight(.thin)
                    }
                    // Extra Temp
                    HStack {
                        extraTemp(temp: Float(Data.weatherData.humidity), image: "thermometer")
                        extraTemp(temp: Data.weatherData.lowTemp, image: "arrow.down")
                        extraTemp(temp: Data.weatherData.highTemp, image: "arrow.up")
                    }
                }
                .padding(.top, 10)
                Spacer()
            }
            .foregroundColor(Color("weatherColor"))
            .padding(.trailing, 10)
            .padding(.leading, 10)
            .background(
                Image("lightAndDark")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
        }
        .onAppear{
            DispatchQueue.main.async {
                self.Data.fetchData(cityName: self.city)
                print("Data fetched \(self.Data.weatherData)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct extraTemp: View {
    let temp: Float
    let image: String
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: image)
            Text(String(format: "%.0f",temp))
        }
    }
}
