//
//  ContentModel.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

class ContentViewModel: ObservableObject {

    let didChange = PassthroughSubject<ContentViewModel,Never>()
    let networkManager = globalBootStrap.networkManager

    var results = [ItunesResult]() {
        didSet {
            didChange.send(self)
        }
    }

    func search(text: String) {
        guard let url = networkManager.buildSearchUrl(text: text) else {
            return
        }

        networkManager.getJson(url: url) { result in
            switch result {
            case .success(let json):
                self.results = json.results
            case .failure(let err):
                debugPrint(err.localizedDescription)
                self.results.removeAll()
            }
        }

    }

}
