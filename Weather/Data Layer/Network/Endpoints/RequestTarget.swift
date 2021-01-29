//
//  BaseTarget.swift
//  MondiaMedia
//
//  Created by Ahmed Osman on 11/21/19.
//  Copyright © 2019 Ahmed Osman. All rights reserved.
//

import Foundation

protocol RequestTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension RequestTarget {
    var baseURL: String {
        return K.URLs.baseURL
    }
    
    var headers: [String : String]? {
        let headers = ["Accept":"application/json"]
        return headers
    }
}

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
