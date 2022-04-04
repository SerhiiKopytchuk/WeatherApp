//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import Foundation

class CurrentWeather{
    var locationWeather:LocationWeather? = nil
    var currentWeather:Current? = nil
    var forecast:Forecast? = nil
}

class Forecast{
    var forecastDay:[ForecastDay]? = []
}

class ForecastDay{
    var date:String? = ""
    var day:DayInfo? = nil
    var hour:[HourlyDayInfo]? = nil
}

class HourlyDayInfo{
    var time:String? = ""
    var tempC:Double? = 0.0
    var tempF:Double? = 0.0
    var condition:Condition? = nil
    var windKph:Double? = nil
    var windMph:Double? = nil
    var feelsLike:Double? = nil
    
    var visibilityKm:Double? = 0.0
    var visibilityMiles:Double? = 0.0
    var cloudPercent:Int? = 0
}


class DayInfo{
    var maxTempC:Double? = 0.0
    var minTempC:Double? = 0.0
    var maxTempF:Double? = 0.0
    var minTempF:Double? = 0.0
    
    var averageTemperatureC:Double? = 0.0
    var averageTemperatureF:Double? = 0.0
    var averageVisibilityKm:Double? = 0.0
    var averageVisibilityMiles:Double? = 0.0
    var chanceOfRain:Double? = 0.0
    var maxWindKph:Double? = 0.0
    var maxWindMph:Double? = 0.0
    
    var condition:Condition? = nil
}

class Condition{
    var text:String? = ""
    var icon:String? = ""
}

class LocationWeather{
    var name:String? = ""
    var country:String? = ""
}

class Current{
    var tempC:Double? = 0.0
    var tempF:Double? = 0.0
    var wind_kph:Double? = 0.0
    var wind_mph:Double? = 0.0
    var wind_dir:String? = ""
    var feelsLikeC:Double? = 0.0
    var feelsLikeF:Double? = 0.0
}

