//
//  MenuView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct MenuView: View {

    @ObservedObject var viewmodel: MenuViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("blink-ios-icon").resizable().frame(width: 200, height: 200).cornerRadius(15)
                Spacer()
                Button(action: {
                    self.viewmodel.isJoining.toggle()
                }) {
                    Text("Join session")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Main"))
                        .cornerRadius(10)
                }
                Spacer().sheet(isPresented: $viewmodel.isJoining) {
                    Browser(delegate: self.viewmodel)
                }
                if viewmodel.isConnected {
                    NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel()), isActive: $viewmodel.isConnected, label: {EmptyView()})
                }
            }
        }
    }
}

