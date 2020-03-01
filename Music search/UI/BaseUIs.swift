//
//  BaseUIs.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

protocol BaseView {
    var route: Route? { get }
    var data: Any? { get set }
    var model: Any?{ get set }
}

struct RootErrorView: View {
    var body: some View {
        Text("MAIN APP ERROR VIEW, FOR INITIALIZATION ERRORS")
    }
}
