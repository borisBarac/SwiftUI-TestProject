//
//  BaseUIs.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

protocol BaseView {
    associatedtype Model: ObservableObject

    var route: Route? { get }
    var data: Any? { get set }
    var model: Model { get set }
}

struct RootErrorView: View {
    var body: some View {
        Text("MAIN APP ERROR VIEW, FOR INITIALIZATION ERRORS")
    }
}

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}
