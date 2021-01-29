//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Ahmed Osman on 24/01/2021.
//

import UIKit

class WeatherPresenter {
    
    private let weatherHandler: WeatherHandlerProtocol
    private let weatherAPI: WeatherAPIProtocol
    private weak var weatherViewControllerDelegate: WeatherViewControllerDelegate?
    
    init(weatherViewControllerDelegate: WeatherViewControllerDelegate?, weatherAPI: WeatherAPIProtocol = WeatherAPI(), weatherHandler: WeatherHandlerProtocol = WeatherHandler()) {
        self.weatherViewControllerDelegate = weatherViewControllerDelegate
        self.weatherAPI = weatherAPI
        self.weatherHandler = weatherHandler
    }
    
    func getForecast(city: String, isOnline: Bool = true) {
        weatherViewControllerDelegate?.showLoader()
        weatherAPI.getWeather(city: city, isOnline: isOnline) { [weak self] (data, error) in
            if let forecast = data?.map(Forecast.self) {
                let weatherUI = self?.mapWeatherAPIData(forecast: forecast)
                self?.weatherViewControllerDelegate?.updateUI(weatherUIModel: weatherUI)
            } else {
                let weatherUI = WeatherUIModel(nowStatus: nil, nowTemp: nil, nowIcon: nil, daysWeather: [])
                self?.weatherViewControllerDelegate?.updateUI(weatherUIModel: weatherUI)
            }
            self?.weatherViewControllerDelegate?.hideLoader()
        }
    }
    
    func mapWeatherAPIData(forecast: Forecast) -> WeatherUIModel {
        var model = WeatherUIModel()
        model.nowIcon = weatherHandler.iconURL(iconName: forecast.list?.first?.weather?.first?.icon)
        model.nowTemp = "\(weatherHandler.kelvinToCelsius(temp: forecast.list?.first?.main?.temp))C"
        model.nowStatus = forecast.list?.first?.weather?.first?.main
        let groupedModels = forecast.list?.group(by: { [weak self] in
            return self?.weatherHandler.getFormattedDate(timeInterval: $0.dt)
        })
        model.daysWeather = groupedModels?.map({ [weak self] in
            var dayWeatherUIModel = DayWeatherUIModel()
            dayWeatherUIModel.date = self?.weatherHandler.getFormattedDate(timeInterval: $0.first?.dt)
            dayWeatherUIModel.timesWeather = $0.map({
                let time = self?.weatherHandler.getFormattedTime(timeInterval: $0.dt)
                let icon = self?.weatherHandler.iconURL(iconName: $0.weather?.first?.icon)
                let temp = self?.weatherHandler.kelvinToCelsius(temp: $0.main?.temp)
                return DayWeatherUIModel.TimeWeatherUIModel(time: time, icon: icon, temp: temp)
            })
            return dayWeatherUIModel
        })
        return model
    }    
}
