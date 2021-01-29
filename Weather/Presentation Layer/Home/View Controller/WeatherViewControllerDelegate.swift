//
//  WeatherViewControllerDelegate.swift
//  Weather
//
//  Created by Ahmed Osman on 29/01/2021.
//

import Foundation

protocol WeatherViewControllerDelegate: class {
    func showLoader()
    func hideLoader()    
    func updateUI(weatherUIModel: WeatherUIModel?)
}
