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

    var body: some View {
        Group {
            if route.hasNavigation {
                NavigationView {
                    CoreView()
                }
            } else {
                CoreView()
            }
        }
    }
}

private struct CoreView: View {
    var body: some View {
        VStack {
            Image(systemName: "person")
                .padding(16)
            Text("BLAB BLA")
                .padding(16)
            Text("BLAB BLA")
                .padding(16)
            Button(action: {
                print(2)
            }) {
                Image(systemName: "square.and.arrow.up")
            }
        }
        .navigationBarTitle("DETAIL VIEW")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(route: Route(routePath: .detail))
    }
}
