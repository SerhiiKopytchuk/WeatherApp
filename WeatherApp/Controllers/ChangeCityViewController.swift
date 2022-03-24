//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 22.03.2022.
//

import UIKit
import CoreLocation


class ChangeCityViewController: UIViewController{
    
    let locationManager = CLLocationManager()
    
    
    
    public var exposedLocation: CLLocation? {
          return self.locationManager.location
      }
    
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        UserDefaults.standard.set([], forKey: "citiesArray")
        cityTableView.reloadData()
        
        do{
            cityTextField.text = UserDefaults.standard.value(forKey: "currentCity") as? String
        }
        
        
        
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cityTextFieldValueChanged(_ sender: UITextField) {
        Manager.shared.getCities(cityStartName: cityTextField.text ?? "") { current in
            DispatchQueue.main.async {
                UserDefaults.standard.set(current, forKey: "citiesArray")
                self.cityTableView.reloadData()
            }
        }
    }
    
    
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        guard let locationCity = UserDefaults.standard.value(forKey:"locationCity") as? String else{
            print("There no City")
            return
        }
  
        UserDefaults.standard.set(locationCity, forKey: "currentCity")
        cityTextField.text = locationCity
        NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
    }
    
    

    

    

    
    
}

extension ChangeCityViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let citiesArray = UserDefaults.standard.value(forKey: "citiesArray") as? [String] else{
            return 0
        }
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityTableViewCell", for: indexPath) as? cityTableViewCell else {return UITableViewCell()}
        
        guard let citiesArray = UserDefaults.standard.value(forKey: "citiesArray") as? [String] else{
            return cell
        }
        cell.cityLabel.text = citiesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cityTableView.deselectRow(at: indexPath, animated: true)
        guard let citiesArray = UserDefaults.standard.value(forKey: "citiesArray") as? [String] else{
            return
        }
        UserDefaults.standard.set(citiesArray[indexPath.row], forKey: "currentCity")
        NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
        navigationController?.popViewController(animated: true)
    }
}

extension ChangeCityViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location2D: CLLocationCoordinate2D = manager.location!.coordinate
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: location2D.latitude, longitude: location2D.longitude)

        geoCoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: Bundle.main.preferredLocalizations[0]), completionHandler: { (placemarks, _) -> Void in
            
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality {
                    UserDefaults.standard.set(city, forKey: "locationCity")
                }
            }
        })
    }
}
