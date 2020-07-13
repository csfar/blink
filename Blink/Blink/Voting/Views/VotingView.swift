//
//  VotingView.swift
//  Blink
//
//  Created by Artur Carneiro on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the voting screen.
struct VotingView: View {
    /// The ViewModel that will be attributed to the View
    @ObservedObject var viewmodel: VotingViewModel

    /// The body of a `VotingView`
    var body: some View {
        VStack {
            Spacer()

            /// The HStack containing the topic and
            /// number of ideas added.
            HStack(alignment: .center) {
                Spacer()
                Text(viewmodel.topic).font(.headline)
                Spacer()
                Text("Time to vote!").font(.headline)
                Spacer()
                Text("\(viewmodel.ideas.reduce(0) { $0 + $1.count })").font(.headline)
                Spacer()
            }
            Spacer()

            /// The `GridView` used to layout the ideas in a
            /// 3-column grid. In this scenario, voting is
            /// possible.
            GridViewVotable(items: viewmodel.ideas, votes: $viewmodel.votes)
            Spacer()

            /// The Button responsible for moving forward to
            /// ranking. Should alert the user before moving on.
            Button(action: {
            }) {
                Image(systemName: "arrow.right")
            }
            Spacer()
        }
    }
}
