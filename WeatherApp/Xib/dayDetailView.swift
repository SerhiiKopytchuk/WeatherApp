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
        
        temperatureLabel.text = String(weather.forecast?.forecastDay?[index].day?.averageTemperatureC ?? 0.0)
        cityNameLabel.text = weather.locationWeather?.name
        locationLabel.text = weather.locationWeather?.country
        self.averageVisibility.text = String(weather.forecast?.forecastDay?[index].day?.averageVisibilityKm ?? 0.0)
        self.MaxWindSpeedLabel.text = String(weather.forecast?.forecastDay?[index].day?.maxWindKph ?? 0.0)
        self.chanceOfRainLabel.text = String(weather.forecast?.forecastDay?[index].day?.chanceOfRain ?? 0.0)
        print(index)
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
        
        switch tempType{
        case "C":
            switch windType{
            case "kph":
                break
            case "mph":
                break
            default: break
            }
        case "F":
            switch windType{
            case "kph":
                break
            case "mph":
                break
                default: break
            }
        default: break
        }
        
    }
    
    
    
    
    static func instanceFromNib() -> dayDetailView {
        return UINib(nibName: "dayDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! dayDetailView
    }
    
}
