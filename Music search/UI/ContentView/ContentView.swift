//
//  ContentView.swift
//  Music search
//
//  Created by Boris Barac on 29/02/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View, BaseView {
    typealias Model = ContentViewModel
    enum ViewState {
        case empty
        case list
    }

    var route: Route?
    var data: Any?
    @ObservedObject var model = Model()

    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            self.model.search(text: self.searchText)
                        }).foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                            self.model.clear()
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)

                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing()
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)

                List(model.results, id: \.id) { result in
                    ContentRow(result: result)
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
    }
}

private struct EmptyContentView: View {
    var body: some View {
        Text("There is no data, search for sometthing")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
