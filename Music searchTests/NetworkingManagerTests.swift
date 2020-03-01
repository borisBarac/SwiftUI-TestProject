//
//  Music_searchTests.swift
//  Music searchTests
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import XCTest
@testable import Music_search

class NetworkingManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        networkManager = NetworkManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchUrl() {
        let url = networkManager.buildSearchUrl(text: "michael")
        guard let unUrl = url?.absoluteString else {
            XCTFail()
            return
        }

        XCTAssert(unUrl.contains(NetworkManager.EndPoints.main.rawValue) && unUrl.contains("michael"))
    }

    func testParsing() {
        var main: MainJson? = nil
        let mainExpectation = expectation(description: "parsed main json to object")

        guard let url = networkManager.buildSearchUrl(text: "michael jackson") else {
            XCTFail()
            return
        }

        networkManager.getJson(url: url) { (result) in
            switch result {
            case .success(let object):
                main = object
                mainExpectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 5) { error in
            XCTAssertNotNil(main)
        }
    }

}
