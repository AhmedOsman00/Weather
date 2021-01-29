//
//  NetworkProvider.swift
//  MondiaMedia
//
//  Created by Ahmed Osman on 11/21/19.
//  Copyright © 2019 Ahmed Osman. All rights reserved.
//

import Foundation

class HTTPClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        
    }
    
    func fetch(endpoint: RequestTarget, completion: @escaping completeClosure) {
        let headers = endpoint.headers
        var urlComponents = URLComponents(string: "\(endpoint.baseURL)\(endpoint.path)")
        urlComponents?.queryItems = endpoint.parameters?.map({ return URLQueryItem(name: $0.key, value: $0.value) })
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = endpoint.method.rawValue
            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    let result = self?.handleResult(result: data, response: response, error: error)
                    completion(result?.0, result?.1)
                }
            }
            task.resume()
        }else{
            let error = NSError(domain: "InvalidURL", code: 1, userInfo: nil)
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
    
    private func handleResult(result: Data?, response: URLResponse?, error: Error?) -> (Data?, Error?) {
        
        if let error = error as NSError? {
            return (nil, error)
        }else if let data = result, let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
            let userInfo: [String: Any?] = ["message": apiError.message, "code": apiError.cod]
            let nserror = NSError(domain: "APIError", code: 2, userInfo: userInfo as [String : Any])
            return (nil, nserror)
        }else{
            return (result, nil)
        }
    }
}
