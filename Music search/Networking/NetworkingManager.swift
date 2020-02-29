//
//  NetworkingManager.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let mainReload = Notification.Name(rawValue: "main_reload")
}

final class NetworkManager {
    enum EndPoints: String {
        case main = "https://s3-eu-west-1.amazonaws.com/skyscanner-prod-takehome-test/flights.json"
    }

    enum NetworkError: Error {
        case didNotWork
    }

    private let urlSession = URLSession.shared

    func getJson(url: String, completionHandler: @escaping (Result<MainJson, NetworkError>) -> Void) {
        guard let request = URL(string: url) else {
            return
        }

        let task = urlSession.dataTask(with: request){ (data, response, error) in
            debugPrint(response as Any)
            guard let data = data else {
                completionHandler(.failure(.didNotWork))
                return
            }

            do {
                let blogPost: MainJson = try JSONDecoder().decode(MainJson.self, from: data)
                completionHandler(.success(blogPost))
                debugPrint(blogPost)
            } catch {
                debugPrint("parseFailed")
                completionHandler(.failure(.didNotWork))
            }
        }
        task.resume()
    }
}
