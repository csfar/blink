//
//  RankingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct RankingView: View {
    @State var ideas: [String] = [String]()

    var body: some View {
        NavigationView {
            List {
                ForEach(ideas, id: \.self) { idea in
                    Text("1. \(idea)")
                }
            }.navigationBarTitle("Ranking")
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
