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
                Text("\(viewmodel.ranking.count)").font(.headline)
                Spacer()
            }
            Spacer()

            /// The list of ideas in order represented by Buttons.
            ScrollView(.vertical){
                ForEach(0 ..< viewmodel.ranking.count) { pos in
                    Button(action: {
                    }) {
                        Text("\(pos + 1). \(self.viewmodel.ranking[pos].key) - \(self.viewmodel.ranking[pos].value) votes")
                            .font(.headline)
                            .frame(width: 500, height: 75, alignment: .center)
                            .padding()
                    }.padding()
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
