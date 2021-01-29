//
//  Constants.swift
//  Weather
//
//  Created by Ahmed Osman on 26/01/2021.
//

import Foundation

struct K {
    struct Nib {
        static let dayWeatherNib = "DayWeatherTableViewCell"
        static let timeWeatherNib = "TimeWeatherCollectionCell"
    }
    struct CellIdentifiers {
        static let dayCellIdentifier = "DayWeatherTableViewCell"
        static let timeCellIdentifier = "TimeWeatherCollectionCell"
    }
    struct URLs {
        static let imageURL = "https://openweathermap.org/img/wn/"
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
    }
    struct Keys {
        static let api = "4feea57adc334d93886baccb9138574b"
    }
    struct Paths {
        static let forecast = "forecast"
    }
    struct Parameters {
        static let city = "q"
        static let apiID = "appid"
    }
    struct Weather {
        static let dateFormat = "EEEE, dd MMM yyyy"
        static let timeFormat = "H"
        static let city = "München"
        static let imageSize = "@2x.png"
        static let weatherLocalFileName = "Weather"
    }
}
