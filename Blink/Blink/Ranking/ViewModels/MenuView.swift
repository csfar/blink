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
                Text("Blink").font(.largeTitle).bold()
                Spacer()
                Button(action: {
                    self.viewmodel.isJoining.toggle()
                }) {
                    Text("Join session")
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                Spacer().sheet(isPresented: $viewmodel.isJoining) {
                    Browser(delegate: self.viewmodel)
                }
                NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel()), isActive: $viewmodel.isConnected, label: {EmptyView()})
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewmodel: MenuViewModel() )
    }
}
