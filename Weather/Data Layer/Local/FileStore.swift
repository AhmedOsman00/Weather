//
//  LocalStore.swift
//  DreamtHome
//
//  Created by Ahmed Osman on 2/22/20.
//  Copyright © 2020 RC Structure. All rights reserved.
//

import Foundation

struct FileStore {
    typealias Key = String

    func fetchBundleFile(withName: String, type: String = "json", completion: @escaping (Data?, Error?)->Void) {
        guard let path = Bundle.main.path(forResource: withName, ofType: type) else { completion(nil, nil);return }
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            } catch {
                print(error, .e)
                completion(nil, error)
            }
        }
    }
}
