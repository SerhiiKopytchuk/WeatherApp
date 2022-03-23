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
    @IBOutlet weak var pressureSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
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
    
    @IBAction func presureChanged(_ sender: UISegmentedControl) {
        switch pressureSegment.selectedSegmentIndex{
        case 0:
            UserDefaults.standard.set("mb", forKey: "pressureType")
        case 1:
            UserDefaults.standard.set("in", forKey: "pressureType")
        default:
            break
        }
    }
    
}
