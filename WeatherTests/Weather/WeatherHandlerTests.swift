//
//  WeatherHandlerTests.swift
//  WeatherTests
//
//  Created by Ahmed Osman on 29/01/2021.
//

import XCTest
@testable import Weather

class WeatherHandlerTests: XCTestCase {

    private var sut: WeatherHandler?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = WeatherHandler()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testKelvinToCelsius() {
        // Given
        let temp = 279.6
        // When
        let resultTemp = sut?.kelvinToCelsius(temp: temp)
        // Then
        XCTAssertEqual(resultTemp, "6°")
    }
    
    func testIconURL() {
        // Given
        let icon = "10d"
        // When
        let resultURL = sut?.iconURL(iconName: icon)
        // Then
        XCTAssertEqual(resultURL, "https://openweathermap.org/img/wn/10d@2x.png")
    }
    
    func testGetFormattedDate() {
        // Given
        let date: Double = 1611910800
        // When
        let resultDate = sut?.getFormattedDate(timeInterval: date)
        // Then
        XCTAssertEqual(resultDate, "Friday, 29 Jan 2021")
    }
    
    func testGetFormattedTime() {
        // Given
        let date: Double = 1611910800
        // When
        let resultTime = sut?.getFormattedTime(timeInterval: date)
        // Then
        XCTAssertEqual(resultTime, "11")
    }
}
