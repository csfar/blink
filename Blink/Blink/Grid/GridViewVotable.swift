//
//  GridViewVotable.swift
//  Blink
//
//  Created by Artur Carneiro on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct GridViewVotable: View {
    /// The 2D matrix containing the items as Strings.
    var items: [[String]]

    @Binding var votes: [String]

    /// The body of a `GridView`
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(items, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { col in
                            HStack {
                                Spacer()

                                /// The Button representing each row as
                                /// a `GridRowView`.
                                Button(action: {
                                    if self.votes.contains(col) {
                                        self.votes.removeAll { $0 == col }
                                    } else {
                                        self.votes.append(col)
                                    }
                                }) {
                                    Text(col)
                                        .frame(minWidth: 200, maxWidth: 300, minHeight: 50, maxHeight: 75)
                                        .padding()
                                    }.padding()
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}
