//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Ahmed Osman on 23/01/2021.
//

import XCTest
@testable import Weather

class WeatherPresenterTests: XCTestCase {

    private var sut: WeatherPresenter?
    private var currentTimeZoneHoursFromGMT: Int {
        return TimeZone.current.secondsFromGMT() / (60*60)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = WeatherPresenter(weatherViewControllerDelegate: MockWeatherViewDelegate(), weatherAPI: MockWeatherAPI())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testMapWeatherAPIData() {
        // Given
        let forecast = Forecast(list: [List(dt: 1611910800, main: Main(temp: 279.6), weather: [Weather(main: "Rain", icon: "10d")]), List(dt: 1611921600, main: Main(temp: 281.12), weather: [Weather(main: "Rain", icon: "10d")]), List(dt: 1611932400, main: Main(temp: 279.49), weather: [Weather(main: "Rain", icon: "10d")]), List(dt: 1611943200, main: Main(temp: 277.68), weather: [Weather(main: "Rain", icon: "10n")]), List(dt: 1611964800, main: Main(temp: 277.28), weather: [Weather(main: "Rain", icon: "10n")]), List(dt: 1611986400, main: Main(temp: 276.79), weather: [Weather(main: "Rain", icon: "10n")]), List(dt: 1611997200, main: Main(temp: 277.5), weather: [Weather(main: "Clouds", icon: "04d")])])
        // When
        let resultModel = sut?.mapWeatherAPIData(forecast: forecast)
        // Expected Result
        let expectedModel = WeatherUIModel(nowStatus: "Rain", nowTemp: "6°C", nowIcon: "https://openweathermap.org/img/wn/10d@2x.png", daysWeather: [DayWeatherUIModel(date: "Friday, 29 Jan 2021", timesWeather: [DayWeatherUIModel.TimeWeatherUIModel(time: "\(9 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/10d@2x.png", temp: "6°"), DayWeatherUIModel.TimeWeatherUIModel(time: "\(12 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/10d@2x.png", temp: "8°"), DayWeatherUIModel.TimeWeatherUIModel(time: "\(15 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/10d@2x.png", temp: "6°"), DayWeatherUIModel.TimeWeatherUIModel(time: "\(18 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/10n@2x.png", temp: "4°")]), DayWeatherUIModel(date: "Saturday, 30 Jan 2021", timesWeather: [DayWeatherUIModel.TimeWeatherUIModel(time: "\(0 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/10n@2x.png", temp: "4°"), DayWeatherUIModel.TimeWeatherUIModel(time: "\(6 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/10n@2x.png", temp: "3°"), DayWeatherUIModel.TimeWeatherUIModel(time: "\(9 + currentTimeZoneHoursFromGMT)", icon: "https://openweathermap.org/img/wn/04d@2x.png", temp: "4°")])])
        // Then
        XCTAssertEqual(resultModel, expectedModel)
    }
}
