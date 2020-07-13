//
//  BrainstormView.swift
//  Blink
//
//  Created by Artur Carneiro on 07/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the brainstorming screen.
struct BrainstormView: View {
    
    /// Observed ViewModel so BrainstormView can get its data.
    @ObservedObject var viewmodel: BrainstormingViewModel
    
    /// The body of a `BrainstormingView`
    var body: some View {
        VStack {
            Spacer()

            /// The HStack containing the topic, timer and
            /// number of ideas added.
            HStack {
                Spacer()
                Text(viewmodel.topic).font(.headline)
                Spacer()
                Text(viewmodel.timer).font(.title)
                Spacer()
                Text("\(viewmodel.ideasMatrix.reduce(0) { $0 + $1.count })").font(.headline)
                Spacer()
            }
            Spacer()
            

            /// The `GridView` used to layout the ideas in a
            /// 3-column grid.
            GridView(items: self.viewmodel.ideasMatrix)
            Spacer()

            /// The HStack containing the buttons for
            /// adding a new idea, using the Apple TV remote,
            /// and moving forward to voting.
            HStack(alignment: .center) {

                /// The Button responsible for adding new ideas
                /// using the Apple TV remote.
                Button(action: {
                }) {
                    Image(systemName: "plus")
                }

                /// The Button responsible for moving forward to
                /// voting. Should alert the user before moving on.
                Button(action: {

                }) {
                    Image(systemName: "arrow.right")
                }
            }.padding()
            Spacer()
        }
    }
}
