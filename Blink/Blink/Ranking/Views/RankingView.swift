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
            Text("\(index)")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(Color("Black"))
            Text("\(content)")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color("Black"))
            Spacer()
            Text("\(votes)")
                .font(.system(.body, design: .rounded)).bold()
                .foregroundColor(Color("Black"))
            Text("votes")
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color("Black"))
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
                Text(viewmodel.topic)
                    .foregroundColor(Color.white)
                    .font(.system(size: 45, weight: .regular, design: .rounded))
                Spacer()
                Text("Ranking")
                    .foregroundColor(Color.white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                Spacer()
            Text("\(viewmodel.ideas.count)")
                    .foregroundColor(Color.white)
                    .font(.system(size: 45, weight: .regular, design: .rounded))
                Spacer()
            }
                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                .background(Color("Main"))

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
            if shouldRestart {
                NavigationLink(destination: MenuView(viewmodel: MenuViewModel()), label: {
                    HStack(alignment: .center) {
                        Image(systemName: "arrow.clockwise")
                        Spacer()
                        Text("Restart")
                        Spacer()
                    }
                }).frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2, height: UIScreen.main.bounds.height * 0.15)
                .foregroundColor(Color("Black"))
                Spacer()
            } else {
                Button(action: {
                    self.shouldRestart.toggle()
                }, label: {
                    HStack(alignment: .center) {
                        Image(systemName: "arrow.clockwise")
                        Spacer()
                        Text("Restart?")
                        Spacer()
                    }
                }).frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2, height: UIScreen.main.bounds.height * 0.15)
                .foregroundColor(Color("Black"))
                Spacer()
            }
        }.navigationBarBackButtonHidden(true).onExitCommand(perform: {})
        .background(Color.white)
        .edgesIgnoringSafeArea(.vertical)
    }
}
