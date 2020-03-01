//
//  ModelStructs.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import Foundation

struct MainJson: Decodable {
    let resultCount: Int
    let results: [ItunesResult]
}

struct ItunesResult: Decodable {
    let kind: String?
    let collectionName: String?
    let trackName: String?
    let artworkUrl100: String?

    var artworkUrl: URL? {
        guard let str = artworkUrl100 else {
            return nil
        }
        return URL(string: str)
    }
}
