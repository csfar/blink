//
//  MenuView.swift
//  Blink
//
//  Created by Artur Carneiro on 06/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representaiton of the main menu. This view should be
/// the app's entry point.
struct MenuView: View {

    @ObservedObject var viewmodel: MenuViewModel
    @ObservedObject var multipeer = Multipeer.shared
    
    /// The body of a `MenuView`.
    var body: some View {
        
        HStack(alignment: .center) {

            /// The Button responsible for setting a timer.
            Button(action: {
            }) {
                Image(systemName: "timer")
            }

            /// The Button responsible for setting a topic.
            Button(action: {
            }) {
                Image(systemName: "t.bubble")
            }

            /// The Button responsible for starting the session.
            Button(action: {
                self.viewmodel.startHosting()
            }) {
                Image(systemName: "play")
            }
//            List() {
//                ForEach(multipeer.connectedPeersName, id: \.self) { peer in
//                    Text(peer)
//                }
//            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewmodel: MenuViewModel())
    }
}
