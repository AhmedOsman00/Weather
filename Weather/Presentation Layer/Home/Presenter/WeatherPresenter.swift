//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Ahmed Osman on 24/01/2021.
//

import UIKit

class WeatherPresenter {
    
    private let weatherAPI: WeatherAPIProtocol
    private weak var weatherViewControllerDelegate: WeatherViewControllerDelegate?
    
    init(weatherViewControllerDelegate: WeatherViewControllerDelegate?, weatherAPI: WeatherAPIProtocol = WeatherAPI()) {
        self.weatherViewControllerDelegate = weatherViewControllerDelegate
        self.weatherAPI = weatherAPI
    }
    
    func getForecast(isOnline: Bool = true) {
        weatherViewControllerDelegate?.showLoader()
        weatherAPI.getWeather(isOnline: isOnline) { [weak self] (data, error) in
            if let forecast = data?.map(Forecast.self) {
                let weatherUI = self?.mapWeatherAPIData(forecast: forecast)
                self?.weatherViewControllerDelegate?.updateUI(weatherUIModel: weatherUI)
            }
            self?.weatherViewControllerDelegate?.hideLoader()
        }
    }
    
    func mapWeatherAPIData(forecast: Forecast) -> WeatherUIModel {
        var model = WeatherUIModel()
        model.nowIcon = iconURL(iconName: forecast.list?.first?.weather?.first?.icon)
        model.nowTemp = "\(calculateTemperature(temp: forecast.list?.first?.main?.temp))C"
        model.nowStatus = forecast.list?.first?.weather?.first?.main
        let groupedModels = forecast.list?.group(by: { [weak self] in
            return self?.calculateDate(timeInterval: $0.dt)
        })
        model.daysWeather = groupedModels?.map({ [weak self] in
            var dayWeatherUIModel = DayWeatherUIModel()
            dayWeatherUIModel.date = self?.calculateDate(timeInterval: $0.first?.dt)
            dayWeatherUIModel.timesWeather = $0.map({
                let time = self?.calculateTime(timeInterval: $0.dt)
                let icon = self?.iconURL(iconName: $0.weather?.first?.icon)
                let temp = self?.calculateTemperature(temp: $0.main?.temp)
                return DayWeatherUIModel.TimeWeatherUIModel(time: time, icon: icon, temp: temp)
            })
            return dayWeatherUIModel
        })
        return model
    }
    
    func calculateTemperature(temp: Double?) -> String {
        return "\(Int((temp ?? 0) - 273))°"
    }
    
    func iconURL(iconName: String?) -> String {
        return "\(K.URLs.imageURL)\(iconName ?? "")\(K.Weather.imageSize)"
    }
    
    func calculateDate(timeInterval: Double?) -> String {
        let fullDate = Date(timeIntervalSince1970: timeInterval ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = K.Weather.dateFormat
        let date = formatter.string(from: fullDate)
        return date
    }
    
    func calculateTime(timeInterval: Double?) -> String {
        let fullDate = Date(timeIntervalSince1970: timeInterval ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = K.Weather.timeFormat
        let time = formatter.string(from: fullDate)
        return time
    }
}
