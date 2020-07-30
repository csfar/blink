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
                .background(Color("Accent"))

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
