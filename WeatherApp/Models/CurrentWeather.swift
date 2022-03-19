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
    var day:DayInfo? = nil
    var hour:[HourlyDayInfo]? = nil
}

class HourlyDayInfo{
    var time:String? = ""
    var tempC:Double? = 0.0
    var condition:Condition? = nil
    var windKph:Double? = nil
    var feelsLike:Double? = nil
}


class DayInfo{
    var maxTempC:Double? = 0.0
    var minTempC:Double? = 0.0
    var condition:Condition? = nil
}

class Condition{
    var text:String? = ""
}

class LocationWeather{
    var name:String? = ""
    var country:String? = ""
}

class Current{
    var tempC:Double? = 0.0
    var wind_kph:Double? = 0.0
    var wind_dir:String? = ""
    var feelsLike:Double? = 0.0
}

