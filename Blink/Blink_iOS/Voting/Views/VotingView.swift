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
    /// Bool type variable that controls if the voting feedback alert box
    /// should appear or not.
    @State var showVotingFeedback: Bool = false
    /// Bool type variable that controls if the alert box that tells
    /// the user if he has voted or not.
    /// Bool type variable that tells if the user has voted or not.
    @State var hasVotted: Bool = false
    /// Binding that has the reference for the State var on the MenuView
    @Binding var hasStarted: Bool
    
    var body: some View {
        VStack {
            /// Conditional to check if iOS user has votted or not.
            if !hasVotted {
                List {
                    ForEach(0 ..< viewmodel.ideas.count) { index in
                        HStack(alignment: .center) {
                            Text("\(self.viewmodel.ideas[index].content)")
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(Color("Background"))

                            Spacer()

                            if self.viewmodel.ideas[index].isSelected {
                                Button(action: {
                                    self.viewmodel.ideas[index].isSelected.toggle()
                                    self.currentlyChosen = self.viewmodel.ideas[index]
                                    self.currentlyChosen = Idea(content: "")
                                }, label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("Background"))
                                        .font(.system(.headline, design: .rounded))
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
                                        .foregroundColor(Color("Background"))
                                        .font(.system(.headline, design: .rounded))
                                })
                            }
                        }
                    }
                }.onAppear {
                    UITableView.appearance().backgroundColor = UIColor(named: "Accent")
                    UITableViewCell.appearance().backgroundColor = UIColor(named: "Accent")
                    UINavigationBar.appearance().tintColor = UIColor(named: "Background")
                }
            } else {
                /// When user has voted, this View Content will appear while he awaits for the TV
                /// to go to the Ranking phase.
                
                /// This Text is just a placeholder. Final design will be put in its place.
                VStack(alignment: .center) {
                    Text("Waiting for TV Mediator to go to ranking phase.")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Background"))
                        .padding()
                }
            }
            /// The conditional that controls when RankingView should appear on screen.
            /// It will only activate when the tv goes to its RankingView.
            if viewmodel.shouldShowRank {
                NavigationLink(destination: RankingView(viewmodel: RankingViewModel(topic: viewmodel.topic, ranking: viewmodel.ideas), hasStarted: $hasStarted), isActive: $viewmodel.shouldShowRank, label: {EmptyView().navigationBarItems(trailing: Text("Rank"))}).isDetailLink(false)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color("Accent"))

            /// All the necessary setup and handling for navigation itens.
            /// Elements such as NavButtons and NavTitles will be configured here
            .navigationBarTitle(Text("Voting").foregroundColor(Color("Background"))).navigationBarBackButtonHidden(true).padding()
            .navigationBarItems(trailing: Button("Send") {
                if self.hasVotted == false {
                    self.viewmodel.checkVotedIdeas(self.viewmodel.ideas)
                    self.showVotingFeedback.toggle()
                }
            }.foregroundColor(Color("Background")))
            /// Alert created to provide a feedback to the user so
            /// he can knows that his idea was sent.
            .alert(isPresented: $showVotingFeedback) {
                Alert(title: Text("Vote Sent!"), message: Text("Your vote was sent to the TV"), dismissButton: .default(Text("Ok!")) { self.hasVotted.toggle()
                    self.viewmodel.inVoting = false
                    })
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

