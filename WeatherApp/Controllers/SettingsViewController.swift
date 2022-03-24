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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tempType = UserDefaults.standard.value(forKey: "temperatureType") as? String else{
            return
        }
        switch tempType{
        case "C":
            temperatureSegment.selectedSegmentIndex = 0
        case "F":
            temperatureSegment.selectedSegmentIndex = 1
        default:
            break
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
            break
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
            break
        }
    }
    
    @IBAction func windSpeedValueChnaged(_ sender: UISegmentedControl) {
        switch windSpeedSegment.selectedSegmentIndex{
        case 0:
            UserDefaults.standard.set("kph", forKey: "windSpeedType")
        case 1:
            UserDefaults.standard.set("mph", forKey: "windSpeedType")
        default:
            break
        }
    }
    
    
}
