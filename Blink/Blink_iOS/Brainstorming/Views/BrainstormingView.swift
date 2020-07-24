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
            Text("Brainstorming").foregroundColor(Color("Main")).font(.title).bold().padding()
            TextField("Idea", text: $newIdea).padding()
                .border(Color("Main"), width: 3)
                .cornerRadius(5)
            
            if !newIdea.isEmpty {
                Button(action: {
                    self.viewmodel.sendIdea(self.newIdea)
                    self.newIdea = ""
                }) {
                    Text("Send").foregroundColor(Color.white).bold()
                }.padding().background(Color("Main")).cornerRadius(10)
            }
            
            if viewmodel.shouldVote {
                NavigationLink(destination: VotingView(viewmodel: VotingViewModel(ideas: self.viewmodel.ideas)), isActive: self.$viewmodel.shouldVote, label: {EmptyView().navigationBarItems(trailing: Text("Vote"))})
            }
            }.navigationBarBackButtonHidden(true).padding()
    }
}

struct BrainstormingView_Previews: PreviewProvider {
    static var previews: some View {
        BrainstormingView(viewmodel: BrainstormingViewModel())
    }
}
