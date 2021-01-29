//
//  DataFacade.swift
//  Weather
//
//  Created by Ahmed Osman on 23/01/2021.
//

import Foundation

class WeatherAPI: WeatherAPIProtocol {
    private let localStore = FileStore()
    private let httpClient = HTTPClient()
    
    func getWeather(city: String, isOnline: Bool = true, completion: @escaping (Data?, Error?)->Void) {
        if isOnline {
            httpClient.fetch(endpoint: WeatherEndPoint.forecast(city: city), completion: completion)
        }else{
            localStore.fetchBundleFile(withName: K.Weather.weatherLocalFileName, completion: completion)
        }
    }
}
