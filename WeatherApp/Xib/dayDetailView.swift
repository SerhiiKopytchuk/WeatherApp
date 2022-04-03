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
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var WindDirectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate:dayDetailViewDelegate?
 

    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        delegate?.vcWasClosed()
    }
    
    func configure(temperature:String, city:String, location:String, feelsLike:String, windSpeed:String, windDirection:String, dateStr:String, image:UIImage){
        
        temperatureLabel.text = temperature
        cityNameLabel.text = city
        locationLabel.text = location
        feelsLikeLabel.text = feelsLike
        WindSpeedLabel.text = windSpeed
        WindDirectionLabel.text = windDirection
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateStr ) ?? nil
        formatter.dateFormat = "EEEE, MMM d"
        let dateFinished = formatter.string(from: date ?? Date.now)
        dateLabel.text = dateFinished
        
        imageView.image = image
    }
    
    static func instanceFromNib() -> dayDetailView {
        return UINib(nibName: "dayDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! dayDetailView
    }
    
}
