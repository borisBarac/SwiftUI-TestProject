//
//  ContentView.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        Text("Detail")
    }
}

struct ContentView: View {
    @State var showingDetail = false

    var body: some View {
        Button(action: {
            self.showingDetail = true
        }) {
            Text("Show Detail")
        }.sheet(isPresented: $showingDetail) {
            DetailView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
