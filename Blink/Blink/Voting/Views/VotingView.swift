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
            /// The HStack containing the topic, timer and
            /// number of ideas added.
            HStack(alignment: .center) {
                Spacer()
                Text(viewmodel.topic)
                    .foregroundColor(Color.white)
                    .font(.system(size: 45, weight: .regular, design: .rounded))
                Spacer()
                Text("Time to vote!")
                    .foregroundColor(Color.white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                Spacer()
                Text("\(viewmodel.ideas.reduce(0) { $0 + $1.count })")
                    .foregroundColor(Color.white)
                    .font(.system(size: 45, weight: .regular, design: .rounded))
                Spacer()
            }
                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                .background(Color("Accent"))
            Spacer()

            /// A votable version of `GridView` following the same 3-column
            /// structure. Requires a `Binding` for voting.
            GridViewVotable(items: $viewmodel.ideas)
            Spacer()

            /// The Button responsible for moving forward to
            /// ranking. Should alert the user before moving on.
            if viewmodel.shouldShowRanking {
                NavigationLink(destination: RankingView(viewmodel: RankingViewModel(ideas: viewmodel.ideas, votedIdeas: viewmodel.votedIdeas, topic: viewmodel.topic)),
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
            }).frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2, height: UIScreen.main.bounds.height * 0.15)
                .foregroundColor(Color("Black"))

            Spacer()
        }.navigationBarBackButtonHidden(true).onExitCommand(perform: {})
            .background(Color.white)
            .edgesIgnoringSafeArea(.vertical)
    }
}
