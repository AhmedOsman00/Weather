//
//  MockWeatherViewDelegate.swift
//  WeatherTests
//
//  Created by Ahmed Osman on 29/01/2021.
//

import Foundation
@testable import Weather

class MockWeatherViewDelegate: WeatherViewControllerDelegate {
    func showLoader() {
    }
    
    func hideLoader() {
    }
    
    func updateUI(weatherUIModel: WeatherUIModel?) {
    }
}
