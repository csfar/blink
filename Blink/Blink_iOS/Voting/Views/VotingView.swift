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
                            Image(systemName: "checkmark.circle.fill").foregroundColor(Color("Main"))
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
                            Image(systemName: "circle").foregroundColor(Color("Main"))
                        })
                    }
                }.font(.headline)
            }
            if viewmodel.shouldShowRank {
                NavigationLink(destination: RankingView(viewmodel: RankingViewModel(topic: viewmodel.topic, ranking: viewmodel.ideas)), isActive: $viewmodel.shouldShowRank, label: {EmptyView().navigationBarItems(trailing: Text("Rank"))})
            }
        }.navigationBarTitle("\(viewmodel.topic)").navigationBarBackButtonHidden(true).padding()
            .navigationBarItems(trailing: Button("Send Votes") {
                self.viewmodel.checkVotedIdeas(self.viewmodel.ideas)
        }.foregroundColor(Color("Main")))
    }
}


struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView(viewmodel: VotingViewModel(ideas: [Idea(content: "Teste"), Idea(content: "Teste2")]))
    }
}
