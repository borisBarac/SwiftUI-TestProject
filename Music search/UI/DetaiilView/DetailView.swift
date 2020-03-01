//
//  DetailView.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let route: Route
    let result: ItunesResult

    var body: some View {
        Group {
            if route.hasNavigation {
                NavigationView {
                    CoreView(result: result)
                }
            } else {
                CoreView(result: result)
            }
        }
    }
}

private struct CoreView: View {
    @State private var showingSheet = false
    let result: ItunesResult

    var body: some View {
        VStack {
            Image(systemName: "person")
                .padding(16)
            Text("BLAB BLA")
                .padding(16)
            Text("BLAB BLA")
                .padding(16)
            Button(action: {
                self.showingSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
            }
            .sheet(isPresented: $showingSheet, content: {
                    ActivityView(activityItems: [NSURL(string: "https://swiftui.gallery")!] as [Any], applicationActivities: nil)
            })
        }
        .navigationBarTitle("DETAIL VIEW")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(route: Route(routePath: .detail), result: ItunesResult(kind: "song", collectionName: "", trackName: "Track name", artworkUrl100: nil))
    }
}
