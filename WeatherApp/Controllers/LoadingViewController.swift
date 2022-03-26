//
//  LoadingViewController.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 26.03.2022.
//

import UIKit

class LoadingViewController: UIViewController {

    
    
    @IBOutlet weak var loadElement: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElement.startAnimating()
    }

}
