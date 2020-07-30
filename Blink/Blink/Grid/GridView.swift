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
                                self.makeText(col, row).focusable()
                            }
                        }.padding()
                    }
                }.padding()
        }
    }
    
    private func makeText(_ idea: Idea, _ row: [Idea]) -> Text {
        guard let indexRow = items.firstIndex(of: row) else { return Text("")}
        guard let indexCol = row.firstIndex(of: idea) else { return Text("")}
        
        
        if ((indexCol + indexRow) % 2 == 0) {
            return Text(idea.content).foregroundColor(Color("Accent")).font(.system(size: 40, weight: .semibold, design: .rounded))
        } else {
            return Text(idea.content).foregroundColor(Color("Black")).font(.system(size: 40, weight: .semibold, design: .rounded))
        }
    }
}


