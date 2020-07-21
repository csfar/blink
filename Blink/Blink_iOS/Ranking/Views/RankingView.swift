//
//  RankingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
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
                    .foregroundColor(Color.gray)
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

struct RankingView: View {
    @ObservedObject var viewmodel: RankingViewModel

    var body: some View {
        List {
            ForEach(0 ..< viewmodel.ranking.count) { index in
                RankingViewRow(index: index + 1, content: self.viewmodel.ranking[index].content, votes: self.viewmodel.ranking[index].votes)
            }
        }.navigationBarTitle("Ranking").navigationBarBackButtonHidden(true).padding()
    }
}
