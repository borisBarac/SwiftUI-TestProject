//
//  ViewModifiers.swift
//  Music search
//
//  Created by Boris Barac on 01/03/2020.
//  Copyright © 2020 Boris Barac. All rights reserved.
//

import SwiftUI

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .font(.body)
    }
}
