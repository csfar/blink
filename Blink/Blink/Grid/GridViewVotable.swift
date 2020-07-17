//
//  GridViewVotable.swift
//  Blink
//
//  Created by Artur Carneiro on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct GridViewVotableRow: View {
    let idea: Idea

    var body: some View {
        HStack {
            Text(idea.content)
            Spacer()
            if idea.isSelected {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
        }.frame(width: 400, height: 50).font(.headline)
    }
}

struct GridViewVotable: View {
    /// The 2D matrix containing the items as Strings.
    @Binding var items: [[Idea]]

    @State private var currentlyChosen: Idea = Idea(content: "")

    /// The body of a `GridView`
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(0 ..< items.count) { row in
                    HStack {
                        ForEach(0 ..< self.items[row].count) { col in
                            HStack {
                                Button(action: {
                                    if self.items[row][col] == self.currentlyChosen {
                                        self.items[row][col].isSelected.toggle()
                                        self.currentlyChosen = Idea(content: "")
                                    } else {
                                        self.items = self.items.map { $0.map {
                                            var idea = $0
                                            if $0 == self.currentlyChosen {
                                                idea.isSelected.toggle()
                                            }
                                            return idea
                                            } }
                                        self.items[row][col].isSelected.toggle()
                                        self.currentlyChosen = self.items[row][col]
                                    }
                                }) {
                                    if self.items[row][col] == self.currentlyChosen {
                                        GridViewVotableRow(idea: self.currentlyChosen)
                                    } else {
                                        GridViewVotableRow(idea: self.items[row][col])
                                    }
                                }.padding()
                            }
                        }
                    }
                }
            }
        }
    }
}
