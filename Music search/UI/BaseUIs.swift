//
//  BaseUIs.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI
import Combine

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

class ImageLoader: ObservableObject {
    private var cancellable: AnyCancellable?
    let objectWillChange = PassthroughSubject<UIImage?, Never>()

    func load(url: URL) {
        self.cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map({ $0.data })
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map({ UIImage(data: $0) })
            .replaceError(with: nil)
            .sink(receiveValue: { image in
                self.objectWillChange.send(image)
            })
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct RemoteImage: View {
    let url: URL
    let imageLoader = ImageLoader()
    @State var image: UIImage? = nil

    var body: some View {
        Group {
            makeContent()
        }
        .onReceive(imageLoader.objectWillChange, perform: { image in
            self.image = image
        })
        .onAppear(perform: {
            self.imageLoader.load(url: self.url)
        })
        .onDisappear(perform: {
            self.imageLoader.cancel()
        })
    }

    private func makeContent() -> some View {
        if let image = image {
            return AnyView(
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
        } else {
            return AnyView(Text("😢"))
        }
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
