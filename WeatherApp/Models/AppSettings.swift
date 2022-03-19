//
//  Settings.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import Foundation


enum TemperatueEnum{
    case C
    case F
}

enum WindSpeedEnum{
    case mph
    case kph
}

enum PressureEnum{
    case MB
    case IN
}

class AppSettings{
    
    var sity:String? = "London"
    var temperature:TemperatueEnum? = TemperatueEnum.C
    var windSpeed:WindSpeedEnum? = WindSpeedEnum.kph
    var pressure:PressureEnum? = PressureEnum.MB
    
}
