//
//  GridView.swift
//  Blink
//
//  Created by Artur Carneiro on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of a 2D grid using
/// `GridRowView` as rows.
struct GridView: View {
    /// The 2D matrix containing the items as Strings.
    var items: [[String]]

    /// Whether the grid's items are votable.
    var isVotingOn: Bool

    /// Initialize a new instance of this type.
    /// - Parameter items: The 2D matrix containing the items as Strings.
    /// - Parameter isVotingOn: Whether the grid's items are votable. False by default.
    init(items: [[String]],
         isVotingOn: Bool = false) {
        self.items = items
        self.isVotingOn = isVotingOn
    }

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
                                }) {
                                    GridRowView(content: col, votable: self.isVotingOn)
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


