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

    /// `VotingView`'s viewmodel.
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
                Text("Time to vote!").font(.title)
                Spacer()
                Text("\(viewmodel.ideas.reduce(0) { $0 + $1.count })").font(.headline)
                Spacer()
            }
            Spacer()

            /// A votable version of `GridView` following the same 3-column
            /// structure. Requires a `Binding` for voting.
            GridViewVotable(items: $viewmodel.ideas)
            Spacer()

            /// The Button responsible for moving forward to
            /// ranking. Should alert the user before moving on.
            if viewmodel.shouldShowRanking {
                NavigationLink(destination: RankingView(viewmodel: RankingViewModel(ideas: viewmodel.ideas, topic: viewmodel.topic)),
                               isActive: $viewmodel.shouldShowRanking,
                               label: {EmptyView()})
            }
            Button(action: {
                self.viewmodel.shouldShowRanking.toggle()
            }, label: {
                HStack(alignment: .center) {
                    Image(systemName: "list.number")
                    Spacer()
                    Text("Rank")
                    Spacer()
                }
            }).frame(width: 400, height: 50).font(.headline)

            Spacer()
        }
    }
}
