//
//  WeatherHandler.swift
//  Weather
//
//  Created by Ahmed Osman on 29/01/2021.
//

import Foundation

protocol WeatherHandlerProtocol {
    func kelvinToCelsius(temp: Double?) -> String
    func iconURL(iconName: String?) -> String
    func getFormattedDate(timeInterval: Double?) -> String
    func getFormattedTime(timeInterval: Double?) -> String
}

struct WeatherHandler: WeatherHandlerProtocol {
    
    func kelvinToCelsius(temp: Double?) -> String {
        return "\(Int((temp ?? 0) - 273))°"
    }
    
    func iconURL(iconName: String?) -> String {
        return "\(K.URLs.imageURL)\(iconName ?? "")\(K.Weather.imageSize)"
    }
    
    /// Get the date formatted
    /// - Parameter timeInterval: the Unix time stamp
    /// - Returns: the date as string in the format "EEEE, dd MMM yyyy" ex. "Friday, 29 Jan 2021"
    func getFormattedDate(timeInterval: Double?) -> String {
        let fullDate = Date(timeIntervalSince1970: timeInterval ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = K.Weather.dateFormat
        let date = formatter.string(from: fullDate)
        return date
    }
    
    /// Get the time formatted
    /// - Parameter timeInterval: the Unix time stamp
    /// - Returns: the time as string in the format "H" ex. "12"
    func getFormattedTime(timeInterval: Double?) -> String {
        let fullDate = Date(timeIntervalSince1970: timeInterval ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = K.Weather.timeFormat
        let time = formatter.string(from: fullDate)
        return time
    }
}
