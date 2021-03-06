//
//  DetailView.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let route: Route?
    @State var result: ItunesResult

    var body: some View {
        Group {
            if route?.hasNavigation ?? false {
                NavigationView {
                    CoreView(result: $result)
                }
            } else {
                CoreView(result: $result)
            }
        }
    }
}

private struct CoreView: View {
    @State private var showingSheet = false
    @Binding var result: ItunesResult

    var remoteImage: RemoteImage? {
        guard let url = result.artworkUrl else {
            return nil
        }
        return RemoteImage(url: url)
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            remoteImage
            Text("Kind: \(result.kind ?? "")")
                .modifier(PrimaryLabel())
            Text("TrackName: \(result.trackName  ?? "")")
                .modifier(PrimaryLabel())
            Text("CollectionName: \(result.collectionName  ?? "")")
                .modifier(PrimaryLabel())
            Button(action: {
                self.showingSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
            }
            .sheet(isPresented: $showingSheet, content: {
                    ActivityView(activityItems: [URL(string: "https://swiftui.gallery")!] as [Any], applicationActivities: nil)
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

struct CoreView_Previews: PreviewProvider {
    @State static var staticResult = ItunesResult(kind: "song", collectionName: "", trackName: "Track name", artworkUrl100: nil)
    static var previews: some View {
        CoreView(result: $staticResult)
    }
}
