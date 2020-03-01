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
    // extra navigation bar
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

    enum RouterError: Error {
        case canNotCalculateRoute
        case canNotMakeView
    }

    var windows: [UIWindow] {
        return UIApplication.shared.connectedScenes.filter { scene -> Bool in
            return scene.activationState == .foregroundActive
        }.map { scene -> UIWindow? in
            return (((scene as? UIWindowScene)?.delegate as? UIWindowSceneDelegate)?.window ?? nil)
        }.compactMap { $0 }

    }

    // checks for logIn, local data, some upgrade option, what ever can be done here
    func calculate(route: Route) throws -> Route {
        switch route.routePath {
        case .detail:
            return Route(routePath: .detail, presentationStyle: .push, embedInNavBar: false, parrentRoutePath: nil)
        case .main:
            return Route(routePath: .main, presentationStyle: .root, embedInNavBar: true, parrentRoutePath: nil)
        default:
            throw RouterError.canNotCalculateRoute
        }
    }

    func makeView(route: Route, data: Any?) throws -> some View {
        let route = try? calculate(route: route)
        switch route?.routePath {
        case .main:
            return ContentView(route: route, data: nil, model: nil, viewState: .empty)
        default:
            throw RouterError.canNotMakeView
        }
    }

}
