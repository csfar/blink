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
    @Binding var items: [[Idea]]

    /// The body of a `GridView`
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(0 ..< items.count) { row in
                    HStack {
                        ForEach(0 ..< self.items[row].count) { col in
                            HStack {
                                Spacer()

                                Button(action: {
                                    self.items[row][col].isSelected.toggle()
                                }) {
                                    Text(self.items[row][col].content)
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
