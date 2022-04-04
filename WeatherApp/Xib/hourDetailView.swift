//
//  hourDetailView.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 04.04.2022.
//

import UIKit

protocol hourDetailViewDelegate:AnyObject{
    func hourVcWasClosed()
}

class hourDetailView: UIView {
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var clouseButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
   
    

    weak var delegate:hourDetailViewDelegate?
    
    func configure(weather:CurrentWeather, index:Int){
        
        var temperature = ""
        var feelsLike = "feelsLike".localized()
        var windSpeed = "windSpeed".localized()
        var visibility = "visibility".localized()
        var clouds = "clouds".localized()
        
        guard let distanceType = UserDefaults.standard.value(forKey: "distanceType") as? String else{ return }
        guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{ return }
        guard let windType = UserDefaults.standard.value(forKey: "windSpeedType") as? String else{ return }
        
        switch tempType{
        case "C":
            temperature = String(weather.forecast?.forecastDay?[0].hour?[index].tempC ?? 0.0)
            temperature += "˚C"
            temperatureLabel.text = temperature
            
            feelsLike += String(weather.forecast?.forecastDay?[0].hour?[index].feelsLikeC ?? 0.0)
            feelsLike += "˚C"
            feelsLikeLabel.text = feelsLike
        case "F":
            temperature = String(weather.forecast?.forecastDay?[0].hour?[index].tempF ?? 0.0)
            temperature += "˚C"
            temperatureLabel.text = temperature
            
            feelsLike += String(weather.forecast?.forecastDay?[0].hour?[index].feelsLikeF ?? 0.0)
            feelsLike += "˚F"
            feelsLikeLabel.text = feelsLike
        default:
            temperature = String(weather.forecast?.forecastDay?[0].hour?[index].tempC ?? 0.0)
            temperature += "˚C"
            temperatureLabel.text = temperature
            
            feelsLike += String(weather.forecast?.forecastDay?[0].hour?[index].feelsLikeC ?? 0.0)
            feelsLike += "˚C"
            feelsLikeLabel.text = feelsLike
        }
        
        switch windType{
        case "kph":
            windSpeed += String(weather.forecast?.forecastDay?[0].hour?[index].windKph ?? 0.0)
            windSpeed += " kph"
            windSpeedLabel.text = windSpeed
        case "mph":
            windSpeed += String(weather.forecast?.forecastDay?[0].hour?[index].windMph ?? 0.0)
            windSpeed += " mph"
            windSpeedLabel.text = windSpeed
        default:
            windSpeed += String(weather.forecast?.forecastDay?[0].hour?[index].windKph ?? 0.0)
            windSpeed += " kph"
            windSpeedLabel.text = windSpeed
        }
        
        switch distanceType{
        case "km":
            visibility += String(weather.forecast?.forecastDay?[0].hour?[index].visibilityKm ?? 0.0)
            visibility += "km".localized()
            self.visibilityLabel.text = visibility
        case "miles":
            visibility += String(weather.forecast?.forecastDay?[0].hour?[index].visibilityMiles ?? 0.0)
            visibility += "miles".localized()
            self.visibilityLabel.text = visibility
        default:
            visibility += String(weather.forecast?.forecastDay?[0].hour?[index].visibilityKm ?? 0.0)
            visibility += "km".localized()
            self.visibilityLabel.text = visibility
        }
        
        
        clouds += String(weather.forecast?.forecastDay?[0].hour?[index].cloudPercent ?? 0) + "%"
        cloudsLabel.text = clouds
        
        let formatter = DateFormatter()
        let dateStr = weather.forecast?.forecastDay?[0].hour?[index].time ?? ""

        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date  = formatter.date(from: dateStr)
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: date ?? Date())
        timeLabel.text = time
        
        imageView.image = UIImage(named: weather.forecast?.forecastDay?[0].hour?[index].condition?.icon ?? "")
        
    }
    
    @IBAction func clouseButtonPressed(_ sender: UIButton) {
        delegate?.hourVcWasClosed()
    }
    
    static func instanceFromNib() -> hourDetailView {
        return UINib(nibName: "hourDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! hourDetailView
    }

}
