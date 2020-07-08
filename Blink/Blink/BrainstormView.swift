//
//  BrainstormView.swift
//  Blink
//
//  Created by Artur Carneiro on 07/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the brainstorming screen.
struct BrainstormView: View {
    /// The 2D matrix containing the ideas as Strings.
    var ideas: [[String]]

    /// The topic set for the session.
    var topic: String

    /// The timer set for the session.
    var timer: String

    /// Initialize a new instance of this type.
    /// - Parameter ideas: 2D matrix containing the ideas as Strings. Empty by default.
    /// - Parameter topic: The topic set for the session. Empty by default.
    /// - Parameter timer: The timer set for the sessiion. Empty by default.
    init(ideas: [[String]] = [[String]](),
         topic: String = "",
         timer: String = "") {
        self.ideas = ideas
        self.topic = topic
        self.timer = timer
    }

    /// The body of a `BrainstormingView`
    var body: some View {
        VStack {
            Spacer()

            /// The HStack containing the topic, timer and
            /// number of ideas added.
            HStack {
                Spacer()
                Text(topic).font(.headline)
                Spacer()
                Text(timer).font(.title)
                Spacer()
                Text("\(ideas.reduce(0) { $0 + $1.count })").font(.headline)
                Spacer()
            }
            Spacer()

            /// The `GridView` used to layout the ideas in a
            /// 3-column grid.
            GridView(items: ideas)
            Spacer()

            /// The HStack containing the buttons for
            /// adding a new idea, using the Apple TV remote,
            /// and moving forward to voting.
            HStack(alignment: .center) {

                /// The Button responsible for adding new ideas
                /// using the Apple TV remote.
                Button(action: {
                }) {
                    Image(systemName: "plus")
                }

                /// The Button responsible for moving forward to
                /// voting. Should alert the user before moving on.
                Button(action: {

                }) {
                    Image(systemName: "arrow.right")
                }
            }.padding()
            Spacer()
        }
    }
}

