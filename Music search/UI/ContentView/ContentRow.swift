//
//  ContentRow.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentRow: View {
    var result: ItunesResult

    var body: some View {
        HStack {
            Text("KIND: \(result.kind ?? "")")
            Spacer()
            Text("Name: \(result.trackName ?? "")")
            Spacer()
        }
    }
}

