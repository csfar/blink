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
    @Binding var items: [[Idea]]

    /// The body of a `GridView`
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(items, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.id) { col in
                            Button(action: {
                            }) {
                                Text(col.content).frame(width: 400, height: 50).font(.headline)
                            }
                        }
                    }
                }
            }.padding()
        }
    }
}


