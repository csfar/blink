//
//  MenuView.swift
//  Blink
//
//  Created by Artur Carneiro on 06/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the main menu. This view should be
/// the app's entry point.
struct MenuView: View {

    /// The body of a `MenuView`.
    var body: some View {
        HStack(alignment: .center) {

            /// The Button responsible for setting a timer.
            Button(action: {
            }) {
                Image(systemName: "timer")
            }

            /// The Button responsible for setting a topic.
            Button(action: {
            }) {
                Image(systemName: "t.bubble")
            }

            /// The Button responsible for starting the session.
            Button(action: {
            }) {
                Image(systemName: "play")
            }
        }
    }
}
