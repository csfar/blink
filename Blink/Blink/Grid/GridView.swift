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
                            HStack {
                                Spacer()
                                Button(action: {
                                }) {
                                    Text(col.content)
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


