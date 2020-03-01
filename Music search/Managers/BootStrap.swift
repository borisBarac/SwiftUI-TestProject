//
//  BootStrap.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import Foundation

var globalBootStrap = BootStrap()

// pointer to shared singletons, with support to inject them and change them
final class BootStrap {
    public enum SetUpType {
        case test,
        staging,
        prod
    }

    // there to make a easy way for Tests to change this
    static func replaceGlobalBootStrap(_ boot: BootStrap) {
        globalBootStrap = boot
    }

    private var _networkManager: NetworkManager
    var networkManager: NetworkManager {
        get {
            return _networkManager
        }
    }

    private var _router: Router
    var router: Router {
        get {
            return _router
        }
    }

    private var _currentSetUp: SetUpType
    var currentSetUp: SetUpType {
        return _currentSetUp
    }


    // DI support for tests
    init(networkManager: NetworkManager = NetworkManager(), router: Router = Router(), setUp: SetUpType = .test) {
        self._networkManager = networkManager
        self._currentSetUp = setUp
        self._router = router
    }

    func resetAll() {
        _networkManager = NetworkManager()
    }

}
