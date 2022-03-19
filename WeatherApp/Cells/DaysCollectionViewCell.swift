//
//  DaysCollectionViewCell.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    func configure(day:String?, month:String?, image:UIImage?, maxTemperature:String?, minTemperature:String?){
        dayLabel.text = day
        monthLabel.text = month
        weatherImageView.image = image
        maxTemperatureLabel.text = maxTemperature
        minTemperatureLabel.text = minTemperature
    }
    
}
