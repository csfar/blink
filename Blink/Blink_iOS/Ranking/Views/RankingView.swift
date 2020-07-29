//
//  RankingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct RankingViewRow: View {
    let position: Int
    let content: String
    let votes: Int
    
    var body: some View {
        HStack {
            if position == 1 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.yellow)
            } else if position == 2 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.gray)
            } else if position == 3 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.orange)
            } else {
                Image(systemName: "minus")
            }
            Text("\(position)").font(.subheadline)
            Text("\(content)").font(.headline)
            Spacer()
            Text("\(votes)").bold()
            Text("votes")
        }
    }
}

struct RankingView: View {
    @ObservedObject var viewmodel: RankingViewModel
    /// Binding that has the reference for the State var on the MenuView
    @Binding var hasStarted: Bool
    
    var body: some View {
        VStack {
            List {
                ForEach(0 ..< viewmodel.ranking.count) { index in
                    RankingViewRow(position: self.viewmodel.ranking[index].position, content: self.viewmodel.ranking[index].content, votes: self.viewmodel.ranking[index].votes)
                }
            }.navigationBarTitle("Ranking").navigationBarBackButtonHidden(true).padding()
            
            /// Restart button to go back to menu.
            /// This will make it possible for the user in iOS
            /// to restart their brainstorming when current one is finished.
            Button(action: {
                self.hasStarted.toggle()
            }) {
                Text("Restart")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
            .padding()
            .background(Color("Main"))
            .cornerRadius(10)
        }
    }
}
