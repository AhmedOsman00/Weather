//
//  APIError.swift
//  MondiaMedia
//
//  Created by Ahmed Osman on 11/24/19.
//  Copyright © 2019 Ahmed Osman. All rights reserved.
//

import Foundation

struct APIError: Codable {
    var cod: Int?
    var message: String?
}
