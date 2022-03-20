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
        
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=d0a9ecd662d7487b911111422221903&q=Vinnytsya&days=7&aqi=no&alerts=no") else {
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
                        
                        
                        guard let forecast = json["forecast"] as? [String:Any] else{
                            return
                        }
                        
                        guard let forecastDay = forecast["forecastday"] as? [[String:Any]] else {
                            return
                        }
                        var forecastArr:[ForecastDay] = []
                        
                        for object in forecastDay{
                            let _forecast = ForecastDay()
                            let dayInf = DayInfo()
                            
                            if let date = object["date"] as? String{
                                _forecast.date = date
                            }
                                
                            guard let day = object["day"] as? [String:Any] else{
                                return
                            }
                            
                            if let maxTempC = day["maxtemp_c"] as? Double{
                                dayInf.maxTempC = maxTempC
                            }
                            
                            if let minTempC = day["mintemp_c"] as? Double{
                                dayInf.minTempC = minTempC
                            }
                            
                            _forecast.day = dayInf
                            
                            let _cond = Condition()
                            
                            guard let condition = day["condition"] as? [String:Any] else {
                                return
                            }
                            
                            if let condText = condition["text"] as? String {
                                _cond.text = condText
                            }
                            
                            if var condIcon = condition["icon"] as? String {
                                _cond.icon = condIcon
                            }
                            
                            dayInf.condition = _cond
                            
                            _forecast.day = dayInf

                            forecastArr.append(_forecast)
                        }
                        
                        
                        let forecastD = Forecast()
                        forecastD.forecastDay = forecastArr
                        currentWeather.forecast = forecastD
                        
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
