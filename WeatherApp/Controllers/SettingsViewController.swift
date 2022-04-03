//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var temperatureSegment: UISegmentedControl!
    @IBOutlet weak var windSpeedSegment: UISegmentedControl!
    @IBOutlet weak var distanceSegment: UISegmentedControl!

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperatureLabel.text = "temperature".localized()
        windSpeedLabel.text = "windSpeed".localized()
        backButton.setTitle("back".localized(), for: .normal)
        distanceLabel.text = "distance".localized()
        
        startSettings()
    }
    
    func startSettings(){
        guard let distanceType = UserDefaults.standard.value(forKey: "distanceType") as? String else{
            return
        }
        switch distanceType{
        case "km":
            distanceSegment.selectedSegmentIndex = 0
        case "miles":
            distanceSegment.selectedSegmentIndex = 1
        default:
            distanceSegment.selectedSegmentIndex = 0
        }
        
        guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
            return
        }
        switch tempType{
        case "C":
            temperatureSegment.selectedSegmentIndex = 0
        case "F":
            temperatureSegment.selectedSegmentIndex = 1
        default:
            temperatureSegment.selectedSegmentIndex = 0
        }
        
        guard let WindSpeedType = UserDefaults.standard.value(forKey: "windSpeedType") as? String else{
            return
        }
        switch WindSpeedType{
        case "kph":
            windSpeedSegment.selectedSegmentIndex = 0
        case "mph":
            windSpeedSegment.selectedSegmentIndex = 1
        default:
            windSpeedSegment.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func temperatureSegmentChanged(_ sender: UISegmentedControl) {
        switch temperatureSegment.selectedSegmentIndex{
        case 0:
            UserDefaults.standard.set("C", forKey: "temperatureType")
        case 1:
            UserDefaults.standard.set("F", forKey: "temperatureType")
        default:
            UserDefaults.standard.set("C", forKey: "temperatureType")
        }
    }
    
    @IBAction func windSpeedValueChnaged(_ sender: UISegmentedControl) {
        switch windSpeedSegment.selectedSegmentIndex{
        case 0:
            UserDefaults.standard.set("kph", forKey: "windSpeedType")
        case 1:
            UserDefaults.standard.set("mph", forKey: "windSpeedType")
        default:
            UserDefaults.standard.set("kph", forKey: "windSpeedType")
        }
    }
    
    @IBAction func distanceWalueChanged(_ sender: UISegmentedControl) {
        switch distanceSegment.selectedSegmentIndex{
        case 0:
            UserDefaults.standard.set("km", forKey: "distanceType")
        case 1:
            UserDefaults.standard.set("miles", forKey: "distanceType")
        default:
            UserDefaults.standard.set("km", forKey: "distanceType")
        }
    }
    
}
