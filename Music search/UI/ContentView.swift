//
//  ContentView.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

struct ContentView: View, BaseView {
    var route: Route?
    var data: Any?
    var model: Any?

    enum ViewState {
        case empty
        case list
    }

    var viewState = ViewState.empty

    var body: some View {
        switch viewState {
        case .empty:
            return Text("empty")
        case .list:
            return Text("List")
        }
    }
}

private struct EmptyContentView: View {
    var body: some View {
        Text("EM")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
