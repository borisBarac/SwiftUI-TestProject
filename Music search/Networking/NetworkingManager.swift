//
//  NetworkingManager.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import Foundation
import Combine

extension NSNotification.Name {
    static let mainReload = Notification.Name(rawValue: "main_reload")
}

final class NetworkManager {
    private let agent = Agent()

    func buildSearchUrl(text: String) -> URL? {
        guard let base = EndPoints.main.url else {
            return nil
        }

        let query = URLQueryItem(name: "term", value: text.replacingOccurrences(of: " ", with: "+"))
        var components = URLComponents(url: base, resolvingAgainstBaseURL: false)
        components?.queryItems = [query]

        return components?.url
    }

    func getJson(url: URL) -> AnyPublisher<MainJson, Error> {
        return run(URLRequest(url: url))
    }

    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return agent.run(request)
            .map(\.value)
            .retry(1)
            .eraseToAnyPublisher()
    }
}

// MARK: - Inline enums
extension NetworkManager {
    enum EndPoints: String {
        case main = "https://itunes.apple.com/search"

        var url: URL! {
            return URL(string: self.rawValue)
        }
    }

    enum NetworkError: Error {
        case didNotWork(error: Error)
    }
}

// MARK: - Agent struct
extension NetworkManager {
    struct Agent {
        let session = URLSession.shared

        struct Response<T> {
            let value: T
            let response: URLResponse
        }

        func run<T: Decodable>(_ request: URLRequest,
                               _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
            return session
                .dataTaskPublisher(for: request)
//                .mapError({ err -> Error in
//                    return NetworkManager.NetworkError.didNotWork(error: err)
//                })
                .tryMap { result -> Response<T> in
                    let value = try decoder.decode(T.self, from: result.data)
                    return Response(value: value, response: result.response)
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
