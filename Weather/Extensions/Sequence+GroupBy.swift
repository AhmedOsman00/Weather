//
//  Sequence+GroupBy.swift
//  Weather
//
//  Created by Ahmed Osman on 25/01/2021.
//

import Foundation

public extension Sequence {
    
    /// Group array according to the passed clouser
    func group<U: Equatable&Hashable>(by key: (Iterator.Element) -> U) -> [[Iterator.Element]] {
        var groups: [[Iterator.Element]] = []
        var keys: [U: Int] = [:]
        for element in self {
            let key = key(element)
            if let index = keys[key] {
                groups[index].append(element)
            }else{
                keys[key] = groups.count
                groups.append([element])
            }
        }
        return groups
    }
}
