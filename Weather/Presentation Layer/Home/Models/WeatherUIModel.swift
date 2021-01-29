//
//  Weather.swift
//  Weather
//
//  Created by Ahmed Osman on 26/01/2021.
//

import Foundation

struct WeatherUIModel: Equatable {
    var nowStatus: String?
    var nowTemp: String?
    var nowIcon: String?
    var daysWeather: [DayWeatherUIModel]?
}
