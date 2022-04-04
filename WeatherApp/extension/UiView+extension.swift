//
//  UiView+extension.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 03.04.2022.
//

import Foundation
import UIKit

extension UIView{
    func rounded(radius: CGFloat = 15){
        self.layer.cornerRadius = radius
    }
}
