//
//  GridRowView.swift
//  Blink
//
//  Created by Artur Carneiro on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of a `GridView`'s row.
struct GridRowView: View {
    /// The content of a row.
    var content: String

    /// Whether a row is votable or not.
    var votable: Bool

    /// Initialize a new instance of this type.
    /// - Parameter items: The content of a row.
    /// - Parameter votable: Whether a row is votable or not.
    init(content: String,
         votable: Bool) {
        self.content = content
        self.votable = votable
    }

    /// The body of a `GridRowView`.
    var body: some View {
        HStack(alignment: .center) {
            Text(content).font(.headline)
            if self.votable {
                Image(systemName: "arrow.up.circle.fill").font(.headline)
            }
        }
    }
}
