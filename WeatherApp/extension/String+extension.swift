//
//  String+extension.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 30.03.2022.
//

import Foundation

extension String{
    func localized() -> String{
        return NSLocalizedString(self, comment: "")
    }
}
