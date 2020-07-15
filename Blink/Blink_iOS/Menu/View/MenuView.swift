//
//  MenuView.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct MenuView: View {
    @ObservedObject var viewmodel: MenuViewModel
    @State private var showingBroswer = false
    
    /// The body of a `MenuView`.
    var body: some View {
        HStack(alignment: .center) {

            /// The Button responsible for starting the session.
            Button(action: {
                self.showingBroswer = true
            }) {
                Image(systemName: "play")
            }
        }
    .sheet(isPresented: $showingBroswer, content: {
        Browser()
    })
    }
}
