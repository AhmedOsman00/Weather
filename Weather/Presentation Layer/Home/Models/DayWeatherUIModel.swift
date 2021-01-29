//
//  DayWeatherUIModel.swift
//  Weather
//
//  Created by Ahmed Osman on 29/01/2021.
//

import Foundation

struct DayWeatherUIModel: Equatable {
    var date: String?
    var timesWeather: [TimeWeatherUIModel]?
    
    struct TimeWeatherUIModel: Equatable {
        var time: String?
        var icon: String?
        var temp: String?
    }
}
