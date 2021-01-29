//
//  MockWeatherAPI.swift
//  WeatherTests
//
//  Created by Ahmed Osman on 29/01/2021.
//

import Foundation
@testable import Weather

class MockWeatherAPI: WeatherAPIProtocol {
    func getWeather(city: String, isOnline: Bool, completion: @escaping (Data?, Error?) -> Void) {
        
    }
}
