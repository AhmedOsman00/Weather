//
//  SearchEndPoint.swift
//  MondiaMedia
//
//  Created by Ahmed Osman on 11/21/19.
//  Copyright © 2019 Ahmed Osman. All rights reserved.
//

import Foundation

enum WeatherEndPoint {
    case forecast(city: String)
}

extension WeatherEndPoint: RequestTarget {
    var path: String {
        return K.Paths.forecast
    }
    
    var method: NetworkMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        switch self {
        case .forecast(let city):
            return [K.Parameters.city: city, K.Parameters.apiID: K.Keys.api]
        }
    }        
}
