//
//  RankingView.swift
//  Blink
//
//  Created by Artur Carneiro on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the ranking screen.
struct RankingView: View {
    /// The list of ideas as an array of Strings.
    var ideas: [String]

    /// The topic set for the session.
    var topic: String

    /// Initialize a new instance of this type.
    /// - Parameter ideas: The list of ideas as an array of Strings.
    /// Ideas should be ordered correctly beforehand.
    /// - Parameter topic: The topic set for the session.
    init(ideas: [String],
         topic: String) {
        self.ideas = ideas
        self.topic = topic
    }

    /// The body of a `RankingView`.
    var body: some View {
        VStack {
            Spacer()

            /// The HStack containing the topic and
            /// number of ideas added.
            HStack(alignment: .center) {
                Spacer()
                Text(topic).font(.headline)
                Spacer()
                Text("Ranking").font(.headline)
                Spacer()
                Text("\(ideas.count)").font(.headline)
                Spacer()
            }
            Spacer()

            /// The list of ideas in order represented by Buttons.
            ForEach(0 ..< ideas.count) { pos in
                Button(action: {
                }) {
                    Text("\(pos + 1). \(self.ideas[pos])")
                }
            }
            Spacer()

            /// The Button responsible for moving back to
            /// the menu. Should alert the user before moving on.
            Button(action: {

            }) {
                Image(systemName: "arrow.clockwise.circle")
            }
            Spacer()
        }
    }
}
