//
//  BrainstormingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct BrainstormingView: View {

    @ObservedObject var viewmodel: BrainstormingViewModel
    @State private var newIdea: String = ""


    var body: some View {
        VStack {
            Text(viewmodel.topic).font(.title).padding()
            TextField("Idea", text: $newIdea).padding()
            Button(action: {
                self.viewmodel.sendIdea(self.newIdea)
            }) {
                Text("Send").foregroundColor(Color.white).bold()
            }.padding().background(Color.red).cornerRadius(10)
            if viewmodel.shouldVote {
                NavigationLink(destination: VotingView(viewmodel: VotingViewModel(ideas: self.viewmodel.ideas)), isActive: self.$viewmodel.shouldVote, label: {EmptyView().navigationBarItems(trailing: Text("Vote"))})
            }
            }.navigationBarBackButtonHidden(true).padding()
    }
}
