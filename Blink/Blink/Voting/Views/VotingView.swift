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
    var viewmodel: VotingViewModel
    
    @State var votes: [String] = [String]()
    
    /// The 2D matrix containing the ideas as Strings.
    var ideas: [[String]]

    /// The topic set for the session
    var topic: String

    /// Initialize a new instance of this type.
    /// - Parameter viewmodel: The ViewModel that the View will receive
    /// - Parameter ideas: 2D matrix containing the ideas as Strings.
    /// - Parameter topic: The topic set for the session.
    init(viewmodel: VotingViewModel,
         ideas: [[String]],
         topic: String) {
        self.viewmodel = viewmodel
        self.ideas = ideas
        self.topic = topic
    }

    /// The body of a `VotingView`
    var body: some View {
        VStack {
            Spacer()

            /// The HStack containing the topic and
            /// number of ideas added.
            HStack(alignment: .center) {
                Spacer()
                Text(topic).font(.headline)
                Spacer()
                Text("Time to vote!").font(.headline)
                Spacer()
                Text("\(ideas.reduce(0) { $0 + $1.count })").font(.headline)
                Spacer()
            }
            Spacer()

            /// The `GridView` used to layout the ideas in a
            /// 3-column grid. In this scenario, voting is
            /// possible.
            GridView(items: ideas, isVotingOn: true)
            Spacer()

            /// The Button responsible for moving forward to
            /// ranking. Should alert the user before moving on.
            Button(action: {
                self.viewmodel.receiveTvVotes(self.votes)
            }) {
                Image(systemName: "arrow.right")
            }
            Spacer()
        }
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
