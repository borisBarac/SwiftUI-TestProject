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
        case main = "https://itunes.apple.com/search"

        var url: URL! {
            return URL(string: self.rawValue)
        }
    }

    enum NetworkError: Error {
        case didNotWork
    }

    private let urlSession = URLSession.shared

    func buildSearchUrl(text: String) -> URL? {
        guard let base = EndPoints.main.url else {
            return nil
        }

        let query = URLQueryItem(name: "term", value: text.replacingOccurrences(of: " ", with: "+"))
        var components = URLComponents(url: base, resolvingAgainstBaseURL: false)
        components?.queryItems = [query]

        return components?.url
    }

    func getJson(url: URL, completionHandler: @escaping (Result<MainJson, NetworkError>) -> Void) {
        let task = urlSession.dataTask(with: url){ (data, response, error) in
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
