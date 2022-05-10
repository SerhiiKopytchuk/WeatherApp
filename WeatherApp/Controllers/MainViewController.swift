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
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    let dayDetailedView = dayDetailView.instanceFromNib()
    let hourDetailedView = hourDetailView.instanceFromNib()
    
    
    var allWeather = CurrentWeather()
    
    var mainModelView = MainViewModel()
    
    //create main object, that will give all info to all thingser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(starSetup), name: .internetDown, object: nil)
        bind()
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
    
    func bind(){
        mainModelView.windSpeedText.bind { text in
            DispatchQueue.main.async {
                self.windSpeedLabel.text = text
            }
        }
        
        mainModelView.temperatureText.bind { text in
            DispatchQueue.main.async {
                self.temperatureLabel.text = text
            }
        }
        
        mainModelView.feelsTemperatureText.bind { text in
            DispatchQueue.main.async {
                self.feelsLikeLabel.text = text
            }
        }
    }
    
    @objc func starSetup(){
        
        //        windSpeedLabel.text = MainView
        mainModelView.setWindSpeedText()
        mainModelView.setTempreatureText()
        mainModelView.setFealsTempreatureText()
        
        
        blurView.isHidden = true
        
        
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
                
                self.allWeather = current
                self.cityName.text = current.locationWeather?.name
                self.countryLabel.text = current.locationWeather?.country

            
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
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.dayCollectionView{
            return CGSize(width: self.dayCollectionView.frame.width/3, height: 200)
        }else{
            return CGSize(width: hourCollectionView.frame.width/3, height: 126)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dayCollectionView{
            return 3
        }else{
            //need count to count num of item
            var count = 0
            let date = Date.now
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let currentHour = formatter.string(from: date)
            count = 24 - (Int(currentHour) ?? 0)
            
            return count
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == self.dayCollectionView{
            
            blurView.isHidden = false
            
            dayDetailedView.frame.origin.x = 0
            dayDetailedView.center.y = view.center.y
            dayDetailedView.frame.size.width = self.view.frame.width
            dayDetailedView.frame.size.height = view.frame.height/2
            //try to configure
            
            
            
            
            dayDetailedView.configure(weather: allWeather, index: indexPath.item)
            
            dayDetailedView.rounded()
            dayDetailedView.delegate = self
            
            UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(self.dayDetailedView)
            }, completion: nil)
            dayCollectionView.deselectItem(at: indexPath, animated: true)
            dayCollectionView.reloadData()
        }else{
            
            blurView.isHidden = false
            
            
            hourDetailedView.frame.origin.x = 0
            hourDetailedView.center.y = view.center.y
            hourDetailedView.frame.size.width = self.view.frame.width
            hourDetailedView.frame.size.height = view.frame.height/2
            
            
            hourDetailedView.rounded()
            hourDetailedView.delegate = self
            
            var count = 0
            let date = Date.now
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let currentHour = formatter.string(from: date)
            count = 24 - (Int(currentHour) ?? 0)
            
            hourDetailedView.configure(weather: allWeather, index: indexPath.item + 24 - count)
            
            UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(self.hourDetailedView)
            }, completion: nil)
            
            hourCollectionView.deselectItem(at: indexPath, animated: true)
            hourCollectionView.reloadData()
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dayCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCollectionViewCell", for: indexPath) as? DaysCollectionViewCell else {return UICollectionViewCell()}
            Manager.shared.sendRequest { current in
                DispatchQueue.main.async {
                    guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
                        return
                    }
                    
                    cell.maxLabel.text = "max".localized()
                    cell.minLabel.text = "min".localized()
                    
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
                    
                    
                    
                    cell.weatherImageView.image = UIImage(named: current.forecast?.forecastDay?[indexPath.item].day?.condition?.icon ?? "Sunny")
                    
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
                    
                    cell.imageView.image = UIImage(named: current.forecast?.forecastDay?[0].hour?[indexPath.item + 24 - count].condition?.icon ?? "Sunny")
                    
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
        return 5
    }
    
}

extension MainViewController:dayDetailViewDelegate{
    func vcWasClosed() {
        blurView.isHidden = true
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.dayDetailedView.removeFromSuperview()
        }, completion: nil)
    }
}

extension MainViewController: hourDetailViewDelegate{
    func hourVcWasClosed() {
        blurView.isHidden = true
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.hourDetailedView.removeFromSuperview()
        }, completion: nil)
    }
}


//362
