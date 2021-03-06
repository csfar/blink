//
//  RankingRowView.swift
//  Blink
//
//  Created by Artur Carneiro on 30/07/20.
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
                    .foregroundColor(Color.white)
            } else if position == 3 {
                Image(systemName: "rosette")
                    .font(.headline)
                    .foregroundColor(Color.orange)
            } else {
                Image(systemName: "minus")
            }
            Text("\(position)")
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
