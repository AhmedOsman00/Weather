//
//  WeatherAPIProtocol.swift
//  Weather
//
//  Created by Ahmed Osman on 29/01/2021.
//

import Foundation

protocol WeatherAPIProtocol {
    func getWeather(city: String, isOnline: Bool, completion: @escaping (Data?, Error?)->Void)
}
