//
//  MenuView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("Blink").font(.largeTitle).bold()
            Spacer()
            Button(action: {
            }) {
                Text("Join session")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
