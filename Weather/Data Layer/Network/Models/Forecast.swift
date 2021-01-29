//
//  Song.swift
//  MondiaMedia
//
//  Created by Ahmed Osman on 11/21/19.
//  Copyright © 2019 Ahmed Osman. All rights reserved.
//

import Foundation

struct Forecast: Codable, Equatable {
    var list: [List]?
}

struct List: Codable, Equatable {
    var dt: Double?
    var main: Main?
    var weather: [Weather]?
}

struct Main: Codable, Equatable {
    var temp: Double?
}

struct Weather: Codable, Equatable {
    var main: String?
    var icon: String?
}
