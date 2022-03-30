//
//  ViewController.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var hourCollectionView: UICollectionView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    //create main object, that will give all info to all things
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(starSetup), name: .internetDown, object: nil)
        
        starSetup()
        
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else{
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func changeCityButtonPressed(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "ChangeCityViewController") as? ChangeCityViewController else{ return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func starSetup(){
        
        locationButton.setTitle("location".localized(), for: .normal)
        settingsButton.setTitle("settings".localized(), for: .normal)

        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController else{
            return
        }
        
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        self.present(controller, animated: true, completion: nil)
        
        
        if UserDefaults.standard.value(forKey: "currentCity") == nil {
            UserDefaults.standard.set("London", forKey: "currentCity")
        }
        
        Manager.shared.sendRequest { current in
            DispatchQueue.main.async {
                guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
                    return
                }
                self.cityName.text = current.locationWeather?.name
                self.countryLabel.text = current.locationWeather?.country
                
                self.feelsLikeLabel.text = "feelsLike".localized()
                self.windSpeedLabel.text = "windSpeed".localized()

                
                switch tempType{
                case "C":
                    self.temperatureLabel.text = String(current.currentWeather?.tempC ?? 0.0) + "˚C"
                    self.feelsLikeLabel.text! += String(current.currentWeather?.feelsLikeC ?? 0.0) + "˚C"
                case "F":
                    self.temperatureLabel.text = String(current.currentWeather?.tempF ?? 0.0) + "˚F"
                    self.feelsLikeLabel.text! += String(current.currentWeather?.feelsLikeF ?? 0.0) + "˚F"
                default:
                    self.temperatureLabel.text = String(current.currentWeather?.tempC ?? 0.0) + "˚C"
                    self.feelsLikeLabel.text! += String(current.currentWeather?.feelsLikeC ?? 0.0) + "˚C"
                }
                
                guard let windType = UserDefaults.standard.value(forKey: "windSpeedType") as? String else{
                    return
                }
                
                switch windType{
                case "kph":
                    self.windSpeedLabel.text! += String(current.currentWeather?.wind_kph ?? 0.0) + " kph"
                case "mph":
                    self.windSpeedLabel.text! += String(current.currentWeather?.wind_mph ?? 0.0) + " mph"
                default:
                    self.windSpeedLabel.text! += String(current.currentWeather?.wind_kph ?? 0.0) + "kph"

                }
               
                
               
               
                
                
                self.windDirectionLabel.text = "windDirection".localized()
                self.windDirectionLabel.text! += current.currentWeather?.wind_dir ?? ""
                
                self.hourCollectionView.reloadData()
                self.dayCollectionView.reloadData()
                
                self.dismiss(animated: true)
                
                print()
            }
        }
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
    }
}

extension MainViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.dayCollectionView{
            return CGSize(width: self.dayCollectionView.frame.width/4, height: 200)
        }else{
            return CGSize(width: hourCollectionView.frame.width/3, height: 126)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dayCollectionView{
            return 3
        }else{
            var count = 0
            let date = Date.now
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let currentHour = formatter.string(from: date)
            count = 24 - (Int(currentHour) ?? 0)
            
            return count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dayCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCollectionViewCell", for: indexPath) as? DaysCollectionViewCell else {return UICollectionViewCell()}
            Manager.shared.sendRequest { current in
                DispatchQueue.main.async {
                    guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
                        return
                    }
                    
                    switch tempType{
                    case "C":
                        cell.minTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.minTempC ?? 0)
                        cell.maxTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.maxTempC ?? 0)
                    case "F":
                        cell.minTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.minTempF ?? 0)
                        cell.maxTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.maxTempF ?? 0)
                    default:
                        cell.minTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.minTempC ?? 0)
                        cell.maxTemperatureLabel.text = String(current.forecast?.forecastDay?[indexPath.item].day?.maxTempC ?? 0)
                    }
                    
                   
                    
                    var iconStr = current.forecast?.forecastDay?[indexPath.item].day?.condition?.icon
                    iconStr?.removeLast(4)
                    iconStr?.removeFirst(35)
                    let iconName = iconStr?.replacingOccurrences(of: "/", with: ":", options: .literal, range: nil)
                    cell.weatherImageView.image = UIImage(named: iconName ?? "Sunny")
                    
                    let dateStr = current.forecast?.forecastDay?[indexPath.item].date
                    
                    let formatter = DateFormatter()

                    
                    formatter.dateFormat = "yyyy-MM-dd"
                    let date = formatter.date(from: dateStr ?? "")
                    
                    formatter.dateFormat = "E"
                    
                    let day = formatter.string(from: date ?? Date())
                    cell.DayName.text = day
                    cell.DayName.text? += "."
                    
                    formatter.dateFormat = "dd"
                    let dayNum = formatter.string(from: date ?? Date())
                    cell.dayLabel.text = dayNum
                }
            }
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursCollectionViewCell", for: indexPath) as? HoursCollectionViewCell else {return UICollectionViewCell()}
            var count = 0
            let date = Date.now
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let currentHour = formatter.string(from: date)
            count = 24 - (Int(currentHour) ?? 0)
            
            Manager.shared.sendRequest { current in
                DispatchQueue.main.async {
                    
                    guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
                        return
                    }
                    
                    switch tempType{
                    case "C":
                        var temp = String(current.forecast?.forecastDay?[0].hour?[indexPath.item + 24 - count].tempC ?? 0.0)
                        temp += "˚C"
                        cell.temperatureLabel.text = temp
                    case "F":
                        var temp = String(current.forecast?.forecastDay?[0].hour?[indexPath.item + 24 - count].tempF ?? 0.0)
                        temp += "˚F"
                        cell.temperatureLabel.text = temp
                    default:
                        var temp = String(current.forecast?.forecastDay?[0].hour?[indexPath.item + 24 - count].tempC ?? 0.0)
                        temp += "˚C"
                        cell.temperatureLabel.text = temp
                    }
                    var iconStr = current.forecast?.forecastDay?[0].hour?[indexPath.item + 24 - count].condition?.icon
                    iconStr?.removeLast(4)
                    iconStr?.removeFirst(35)
                    let iconName = iconStr?.replacingOccurrences(of: "/", with: ":", options: .literal, range: nil)
                    cell.imageView.image = UIImage(named: iconName ?? "Sunny")
                    
                    let dateStr = current.forecast?.forecastDay?[0].hour?[indexPath.item + 24 - count ].time
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let date = formatter.date(from: dateStr ?? "")
                    formatter.dateFormat = "HH:mm"
                    let time = formatter.string(from: date ?? Date())
                    cell.timeLabel.text = time
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}


