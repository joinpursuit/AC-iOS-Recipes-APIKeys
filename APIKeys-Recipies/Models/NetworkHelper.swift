//
//  NetworkHelper.swift
//  APIKeys-Recipies
//
//  Created by C4Q  on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case badURL
    case codingError(rawError: Error)
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    func performDataTask(with url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        let task = session.dataTask(with: url){(data: Data? , response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else { errorHandler(AppError.badData); return }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
        }
        task.resume()
    }
}
