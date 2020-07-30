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
                Image("blink-icon-menu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .shadow(radius: 5, y: 15)
                Spacer()
                Button(action: {
                    self.viewmodel.isJoining.toggle()
                }) {
                    Text("Join session")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(Color("Accent"))
                }
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.1)
                .background(Color("Background"))
                .cornerRadius(15)
                .shadow(radius: 5, y: 15)

                Spacer().sheet(isPresented: $viewmodel.isJoining) {
                    Browser(delegate: self.viewmodel).onDisappear() {
                        self.hasStarted = true
                    }
                }
                if viewmodel.isConnected {
                    NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel(), hasStarted: $hasStarted), isActive: $hasStarted, label: {EmptyView()}).isDetailLink(false)
                }
            }.frame(width: UIScreen.main.bounds.width)
                .background(Color("Accent"))
                .edgesIgnoringSafeArea(.vertical)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            /// This guarantee that the hasStarted var stays false when this view has appeared.
            .onAppear() {
                self.hasStarted = false
                UINavigationBar.appearance().backgroundColor = UIColor(named: "Accent")
        }
    }
}

