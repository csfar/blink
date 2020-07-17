//
//  VotingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct VotingView: View {
    @ObservedObject var viewmodel: VotingViewModel


    @State var currentlyChosen: Idea = Idea(content: "")

    var body: some View {
        List {
            ForEach(0 ..< viewmodel.ideas.count) { index in
                HStack(alignment: .center) {
                    Text("\(self.viewmodel.ideas[index].content)")
                    Spacer()
                    if self.viewmodel.ideas[index].isSelected {
                        Button(action: {
                            self.viewmodel.ideas[index].isSelected.toggle()
                            self.currentlyChosen = self.viewmodel.ideas[index]
                            self.currentlyChosen = Idea(content: "")
                        }, label: {
                            Image(systemName: "checkmark.circle.fill")
                        })
                    } else {
                        Button(action: {
                            self.viewmodel.ideas[index].isSelected.toggle()
                            self.viewmodel.ideas = self.viewmodel.ideas.map {
                                var idea = $0
                                if $0 == self.currentlyChosen {
                                    idea.isSelected.toggle()
                                }
                                return idea
                            }
                            self.currentlyChosen = self.viewmodel.ideas[index]
                        }, label: {
                            Image(systemName: "circle")
                        })
                    }
                }.font(.headline)
            }
        }.navigationBarTitle("\(viewmodel.topic)")
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView(viewmodel: VotingViewModel())
    }
}
