//
//  RouterTests.swift
//  Music searchTests
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import XCTest
@testable import Music_search

class RouterTests: XCTestCase {

    var router: Router!

    override func setUp() {
        router = Router()
    }

    override func tearDown() {
    }

    func testMainRoute() {
        guard let route = try? router.calculate(route: Route(routePath: .main)) else {
            XCTFail("ROUTE IS NIL")
            return
        }
        let pass = route.embedInNavBar == true && route.hasNavigation == false && route.routePath == .main && route.presentationStyle == .root
        XCTAssert(pass)
    }

    func testMakeView() {
        let main = try? router.makeView(route: Route(routePath: .main), data: nil)
        let detail = try? router.makeView(route: Route(routePath: .detail), data: ItunesResult(kind: "", collectionName: "", trackName: "", artworkUrl100: nil))

        XCTAssert((main != nil) && (detail != nil))
    }

}
