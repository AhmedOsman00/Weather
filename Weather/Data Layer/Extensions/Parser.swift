//
//  Parser.swift
//  Weather
//
//  Created by Ahmed Osman on 23/01/2021.
//

import Foundation

extension Data {
    func map<T: Codable> (_ model: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(model, from: self)
        } catch {
            print(error, .e)            
            return nil
        }
    }
}
