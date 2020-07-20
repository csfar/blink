//
//  RankingView.swift
//  Blink
//
//  Created by Artur Carneiro on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct RankingViewRow: View {
    let index: Int
    let content: String
    let votes: Int

    var body: some View {
        HStack {
            if index == 1 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.yellow)
            } else if index == 2 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.white)
            } else if index == 3 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.orange)
            } else {
                Image(systemName: "minus")
            }
            Text("\(index)").font(.subheadline)
            Text("\(content)").font(.headline)
            Spacer()
            Text("\(votes)").bold()
            Text("votes")
        }
    }
}

/// Representation of the ranking screen.
struct RankingView: View {
    /// `RankingView`s ViewModel.
    @ObservedObject var viewmodel: RankingViewModel
    @State var shouldRestart: Bool = false

    /// The body of a `RankingView`.
    var body: some View {
        VStack {
            Spacer()

            /// The HStack containing the topic and
            /// number of ideas added.
            HStack(alignment: .center) {
                Spacer()
                Text(viewmodel.topic).font(.headline)
                Spacer()
                Text("Ranking").font(.title)
                Spacer()
                Text("\(viewmodel.ideas.count)").font(.headline)
                Spacer()
            }
            Spacer()

            /// The list of ideas in order represented by Buttons.
            ScrollView(.vertical){
                ForEach(0 ..< viewmodel.ideas.count) { index in
                    Button(action: {
                    }) {
                        RankingViewRow(index: index + 1, content: self.viewmodel.ideas[index].content, votes: self.viewmodel.ideas[index].votes)
                        .frame(width: 1000, height: 50)
                    }.padding()
                }
            }
            Spacer()

            /// The Button responsible for moving back to
            /// the menu. Should alert the user before moving on.
            /// This button works as a NavigationLink.
            NavigationLink(destination: MenuView(viewmodel: MenuViewModel()), label: {
                HStack(alignment: .center) {
                    Image(systemName: "arrow.clockwise")
                    Spacer()
                    Text("Restart")
                    Spacer()
                }.frame(width: 400, height: 50).font(.headline)
            })
            Spacer()
        }
    }
}
