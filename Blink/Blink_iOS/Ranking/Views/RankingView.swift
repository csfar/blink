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
                .foregroundColor(Color("Background"))
            }
<<<<<<< HEAD
            Text("\(index)")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(Color("Background"))
            Text("\(content)")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color("Background"))
=======
            Text("\(position)").font(.subheadline)
            Text("\(content)").font(.headline)
>>>>>>> 09538a42bb2e528ca67bff603ba04c39b74e84be
            Spacer()
            Text("\(votes)")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color("Background"))
            Text("votes")
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color("Background"))
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
            }
            .onAppear(perform: {
                UITableViewCell.appearance().backgroundColor = UIColor(named: "Accent")
                UITableView.appearance().backgroundColor = UIColor(named: "Accent")
            }).navigationBarTitle("Ranking").navigationBarBackButtonHidden(true).padding()
            
            /// Restart button to go back to menu.
            /// This will make it possible for the user in iOS
            /// to restart their brainstorming when current one is finished.
            Button(action: {
                self.hasStarted.toggle()
            }) {
                Text("Restart")
                    .font(.system(.headline, design: .rounded))
                    .bold()
                    .foregroundColor(Color("Accent"))
            }
            .frame(width: UIScreen.main.bounds.width * 0.4,
                   height: UIScreen.main.bounds.height * 0.1)
                .background(Color("Background"))
                .cornerRadius(15)
                .shadow(radius: 5, y: 15)

            Spacer(minLength: 20)
        }.background(Color("Accent"))
    }
}
