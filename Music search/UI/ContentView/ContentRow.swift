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

    func makeDestination() -> AnyView {
        if let detailView = try? globalBootStrap.router.makeView(route: Route(routePath: .detail), data: result) {
            return AnyView(detailView)
        } else {
            return AnyView(EmptyContentView())
        }

    }

    var body: some View {
        NavigationLink(destination: {
            self.makeDestination()
        }()) {
            HStack(spacing: 16) {
                Text("KIND: \(result.kind ?? "")")
                    .modifier(PrimaryLabel())
                Text("Name: \(result.trackName ?? "")")
                    .modifier(PrimaryLabel())
            }
        }



        
    }
}

