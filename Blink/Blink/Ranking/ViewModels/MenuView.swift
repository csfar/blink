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
    /// This a Bool type var that controls if the Brainstorming
    /// session has started or not.
    @State var hasStarted: Bool = false
    
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
                }
                .padding()
                .background(Color("Main"))
                .cornerRadius(10)
                Spacer().sheet(isPresented: $viewmodel.isJoining) {
                    Browser(delegate: self.viewmodel).onDisappear() {
                        self.hasStarted = true
                    }
                }
                if viewmodel.isConnected {
                    NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel(), hasStarted: $hasStarted), isActive: $hasStarted, label: {EmptyView()}).isDetailLink(false)
                }
            }
            }.navigationBarBackButtonHidden(true).navigationBarHidden(true)
            /// This guarantee that the hasStarted var stays false when this view has appeared.
            .onAppear() {
                self.hasStarted = false
        }
    }
}

