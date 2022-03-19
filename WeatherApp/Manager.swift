//
//  Manager.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import Foundation

class Manager{
    private init(){}
    static let shared = Manager()
    
    func sendRequest(competition: @escaping (_ current:CurrentWeather)->()){
        
        
        let currentWeather = CurrentWeather()
        
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=d0a9ecd662d7487b911111422221903&q=Vinnytsya&aqi=no") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        
                      
                        
                        guard let location = json["location"] as? [String:Any] else {
                            return
                        }
                        guard let current = json["current"] as? [String:Any] else{
                            return
                        }
                        
                        let _location = LocationWeather()
                        
                        if let name = location["name"] as? String{
                            _location.name = name
                        }
                        
                        if let country = location["country"] as? String{
                            _location.country = country
                        }
                        
                        currentWeather.locationWeather = _location
                        
                        let _current = Current()
                        
                        if let tempC = current["temp_c"] as? Double{
                            _current.tempC = tempC
                        }
                        
                        if let windKph = current["wind_kph"] as? Double{
                            _current.wind_kph = windKph
                        }
                        
                        if let feelsLike = current["feelslike_c"] as? Double{
                            _current.feelsLike = feelsLike
                        }
                        
                        if let windDir = current["wind_dir"] as? String{
                            _current.wind_dir = windDir
                        }
                        
                        currentWeather.currentWeather = _current
                        
                        //get all info that I need
                        
                        competition(currentWeather)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}
