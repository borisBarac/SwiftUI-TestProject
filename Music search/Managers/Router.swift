//
//  Router.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import UIKit
import SwiftUI

struct Route: Decodable, Encodable {
    enum PresentationStyle: String, Decodable, Encodable {
        case push
        case pop
        case root
    }

    enum RoutePath: String, Decodable, Encodable {
        case main
        case detail
        case error
    }

    let routePath: RoutePath
    let presentationStyle: PresentationStyle
    let embedInNavBar: Bool
    let parrentRoutePath: String?
    let hasNavigation: Bool

    init(routePath: RoutePath, presentationStyle: PresentationStyle = .push, embedInNavBar: Bool = false, parrentRoutePath: String? = nil, hasNavigation: Bool = false) {
        self.routePath = routePath
        self.presentationStyle = presentationStyle
        self.embedInNavBar = embedInNavBar
        self.parrentRoutePath = parrentRoutePath
        self.hasNavigation = hasNavigation
    }

    static func makeMainErorRoute(error: Error) -> Route {
        return Route(routePath: .error, parrentRoutePath: nil, hasNavigation: false)
    }
}

final class Router {

    var windows: [UIWindow] {
        return UIApplication.shared.connectedScenes.filter { scene -> Bool in
            return scene.activationState == .foregroundActive
        }.map { scene -> UIWindow? in
            return (((scene as? UIWindowScene)?.delegate as? UIWindowSceneDelegate)?.window ?? nil)
        }.compactMap { $0 }

    }

    // checks for logIn, local data, some upgrade option, what ever can be done here
    func calculate(route: Route) -> Result<Route?, Never> {

        // network checks need to be locked with DispatchSemaphore

        switch route.routePath {
        case .detail:
            return .success(Route(routePath: .detail, presentationStyle: .push, embedInNavBar: false, parrentRoutePath: nil))
        case .main:
            return .success(Route(routePath: .main, presentationStyle: .root, embedInNavBar: true, parrentRoutePath: nil))
        default:
            return .success(nil)
        }
    }

    func makeView(route: Route, data: Any?) throws -> some View {
        return ContentView()
    }

}
