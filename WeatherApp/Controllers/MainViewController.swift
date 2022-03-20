//
//  ViewController.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var dayCollectionView: UICollectionView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    //create main object, that will give all info to all things
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.shared.sendRequest { current in
            DispatchQueue.main.async {
                self.temperatureLabel.text = String(current.currentWeather?.tempC ?? 0.0) + "˚C"
                self.cityName.text = current.locationWeather?.name
                self.countryLabel.text = current.locationWeather?.country
                
                self.feelsLikeLabel.text = "Feels like: "
                self.feelsLikeLabel.text! += String(current.currentWeather?.feelsLike ?? 0.0)
                self.windSpeedLabel.text = "Wind Speed: "
                self.windSpeedLabel.text! += String(current.currentWeather?.wind_kph ?? 0.0)
                self.windDirectionLabel.text = "Wind direction: "
                self.windDirectionLabel.text! += current.currentWeather?.wind_dir ?? ""
                
                print()
            }
        }
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
    }
    
    
}

extension MainViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.dayCollectionView.frame.width/4, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCollectionViewCell", for: indexPath) as? DaysCollectionViewCell else {return UICollectionViewCell()}
        
        
        Manager.shared.sendRequest { current in
            DispatchQueue.main.async {
                cell.minTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.minTempC ?? 0)
                cell.maxTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.maxTempC ?? 0)
                
                var iconStr = current.forecast?.forecastDay?[indexPath.item].day?.condition?.icon
                iconStr?.removeLast(4)
                iconStr?.removeFirst(35)
                let iconName = iconStr?.replacingOccurrences(of: "/", with: ":", options: .literal, range: nil)
                cell.weatherImageView.image = UIImage(named: iconName ?? "Sunny")
                
                let dateStr = current.forecast?.forecastDay?[indexPath.item].date
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.date(from: dateStr ?? "")
                formatter.dateFormat = "MMMM"
                let month = formatter.string(from: date ?? Date())
                cell.monthLabel.text = month
                formatter.dateFormat = "dd"
                let day = formatter.string(from: date ?? Date())
                cell.dayLabel.text = day
            }
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}


