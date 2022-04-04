//
//  dayDetailView.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 03.04.2022.
//

import UIKit

protocol dayDetailViewDelegate:AnyObject{
    func vcWasClosed()
}

class dayDetailView: UIView {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var averageVisibility: UILabel!
    @IBOutlet weak var MaxWindSpeedLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate:dayDetailViewDelegate?
    
    
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        delegate?.vcWasClosed()
    }
    
    func configure(weather:CurrentWeather, index:Int){
        
        var temperature = ""
        var avgVis = "averageVisibility".localized()
        var maxWindSpeed = "maxWindSpeed".localized()
        var ChanceOfRain = "chanceOfRain".localized()
        
        guard let distanceType = UserDefaults.standard.value(forKey: "distanceType") as? String else{ return }
        
        switch distanceType{
        case "km":
            avgVis += String(weather.forecast?.forecastDay?[index].day?.averageVisibilityKm ?? 0.0)
            avgVis += "km".localized()
            self.averageVisibility.text = avgVis
        case "miles":
            avgVis += String(weather.forecast?.forecastDay?[index].day?.averageVisibilityMiles ?? 0.0)
            avgVis += "miles".localized()
            self.averageVisibility.text = avgVis
        default:
            avgVis += String(weather.forecast?.forecastDay?[index].day?.averageVisibilityKm ?? 0.0)
            avgVis += "km"
            self.averageVisibility.text = avgVis
        }
        
        
        cityNameLabel.text = weather.locationWeather?.name
        locationLabel.text = weather.locationWeather?.country
        
        
        
        
        ChanceOfRain += String(weather.forecast?.forecastDay?[index].day?.chanceOfRain ?? 0.0)
        if ChanceOfRain ==  "chanceOfRain".localized() + "0.0"{
            ChanceOfRain = "chanceOfRain".localized() + "noInfo".localized()
        }else{
            ChanceOfRain += "%"
        }
        self.chanceOfRainLabel.text = ChanceOfRain
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: weather.forecast?.forecastDay?[index].date ?? "") ?? nil
        formatter.dateFormat = "EEEE, MMM d"
        let dateFinished = formatter.string(from: date ?? Date.now)
        dateLabel.text = dateFinished
        
        
        
        imageView.image = UIImage(named: weather.forecast?.forecastDay?[index].day?.condition?.icon ?? "")
        
        guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
            return
        }
        
        guard let windType = UserDefaults.standard.value(forKey: "windSpeedType") as? String else{
            return
        }
        
        switch windType{
        case "kph":
            maxWindSpeed += String(weather.forecast?.forecastDay?[index].day?.maxWindKph ?? 0.0)
            maxWindSpeed += " kph"
            MaxWindSpeedLabel.text = maxWindSpeed
        case "mph":
            maxWindSpeed += String(weather.forecast?.forecastDay?[index].day?.maxWindMph ?? 0.0)
            maxWindSpeed += " mph"
            MaxWindSpeedLabel.text = maxWindSpeed
        default:
            maxWindSpeed += String(weather.forecast?.forecastDay?[index].day?.maxWindKph ?? 0.0)
            maxWindSpeed += " kph"
            MaxWindSpeedLabel.text = maxWindSpeed
        }
        
        switch tempType{
        case "C":
            temperature = String(weather.forecast?.forecastDay?[index].day?.averageTemperatureC ?? 0.0)
            temperature += "˚C"
            temperatureLabel.text = temperature
        case "F":
            temperature = String(weather.forecast?.forecastDay?[index].day?.averageTemperatureF ?? 0.0)
            temperature += "˚C"
            temperatureLabel.text = temperature
        default:
            temperature = String(weather.forecast?.forecastDay?[index].day?.averageTemperatureC ?? 0.0)
            temperature += "˚C"
            temperatureLabel.text = temperature
        }
        
    }
    
    
    
    
    static func instanceFromNib() -> dayDetailView {
        return UINib(nibName: "dayDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! dayDetailView
    }
    
}
