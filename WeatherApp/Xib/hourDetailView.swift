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
    
    var fellsLike = "feelsLike".localized()
    var windSpeed = "windSpeed".localized()
    var visibility = "visibility".localized()
    var clouds = "clouds".localized()
    

    weak var delegate:hourDetailViewDelegate?
    
    func configure(weather:CurrentWeather, index:Int){
        
    }
    
    @IBAction func clouseButtonPressed(_ sender: UIButton) {
        delegate?.hourVcWasClosed()
    }
    
    static func instanceFromNib() -> hourDetailView {
        return UINib(nibName: "hourDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! hourDetailView
    }

}
