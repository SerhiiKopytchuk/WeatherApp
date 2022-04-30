//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 30.04.2022.
//

import Foundation


class MainViewModel{
    
    var windSpeedText = Bindable<String>("")
    var temperatureText = Bindable<String>("")
    var feelsTemperatureText = Bindable<String>("")
    
    private func getCurrent() -> CurrentWeather{
        var _current = CurrentWeather()
        Manager.shared.sendRequest { current in
            _current = current
        }
        return _current
    }
    
    func setWindSpeedText(){
        DispatchQueue.main.async {
            Manager.shared.sendRequest { current in
                
                guard let windType = UserDefaults.standard.value(forKey: "windSpeedType") as? String else{
                    return
                }
                
                self.windSpeedText.value = "windSpeed".localized()
                
                switch windType{
                case "kph":
                    self.windSpeedText.value += String(current.currentWeather?.wind_kph ?? 0.0) + " kph"
                case "mph":
                    self.windSpeedText.value += String(current.currentWeather?.wind_mph ?? 0.0) + " mph"
                default:
                    self.windSpeedText.value += String(current.currentWeather?.wind_kph ?? 0.0) + "kph"
                }
            }
        }
        
    }
    func setTempreatureText(){
        DispatchQueue.main.async {
            Manager.shared.sendRequest { current in
                
                guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
                    return
                }
                
                
                
                switch tempType{
                case "C":
                    self.temperatureText.value = String(current.currentWeather?.tempC ?? 0.0) + "˚C"
                case "F":
                    self.temperatureText.value = String(current.currentWeather?.tempF ?? 0.0) + "˚F"
                default:
                    self.temperatureText.value = String(current.currentWeather?.tempC ?? 0.0) + "˚C"
                }
                
            }
        }
    }
    
    func setFealsTempreatureText(){
        DispatchQueue.main.async {
            Manager.shared.sendRequest { current in
                
                guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
                    return
                }
                
                self.feelsTemperatureText.value = "feelsLike".localized()
                
                switch tempType{
                case "C":
                    self.feelsTemperatureText.value += String(current.currentWeather?.feelsLikeC ?? 0.0) + "˚C"
                case "F":
                    self.feelsTemperatureText.value += String(current.currentWeather?.feelsLikeC ?? 0.0) + "˚F"
                default:
                    self.feelsTemperatureText.value += String(current.currentWeather?.feelsLikeC ?? 0.0) + "˚C"
                }
                
            }
        }
    }
}
