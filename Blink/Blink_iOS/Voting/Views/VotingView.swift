//
//  VotingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct VotingView: View {
    @State var ideas: [String] = [String]()
    var body: some View {
        NavigationView {
            List {
                ForEach(ideas, id: \.self) { idea in
                    HStack(alignment: .center) {
                        Text("\(idea)")
                        Spacer()
                        Image(systemName: "circle")
                    }
                }
            }.navigationBarTitle("Poll")
        }
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView()
    }
}
