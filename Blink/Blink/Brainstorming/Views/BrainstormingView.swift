//
//  BrainstormingView.swift
//  Blink
//
//  Created by Artur Carneiro on 07/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the brainstorming screen.
struct BrainstormingView: View {
    
    /// `BrainstormingView`'s viewmodel.
    @ObservedObject var viewmodel: BrainstormingViewModel
    
    @State var newIdea: String = ""
    @State var shouldVote: Bool = false
    @State var showKeyboard: Bool = false
    
    /// The body of a `BrainstormingView`
    var body: some View {
        VStack {

            /// The HStack containing the topic, timer and
            /// number of ideas added.
            HStack(alignment: .center) {
                Spacer()
                Text(viewmodel.timer)
                    .foregroundColor(Color.white)
                    .font(.system(size: 45, weight: .regular, design: .rounded))
                Spacer()
                Text(viewmodel.topic)
                    .foregroundColor(Color.white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                Spacer()
                Text("\(viewmodel.ideasMatrix.reduce(0) { $0 + $1.count })")
                    .foregroundColor(Color.white)
                    .font(.system(size: 45, weight: .regular, design: .rounded))
                Spacer()
            }
                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                .background(Color("Accent"))
                
            Spacer()
            
            /// The `GridView` used to layout the ideas in a
            /// 3-column grid.
            GridView(items: $viewmodel.ideasMatrix)
            Spacer()
            
            /// The HStack containing the buttons for
            /// adding a new idea, using the Apple TV remote,
            /// and moving forward to voting.
            HStack(alignment: .center) {
                
                VStack {
                    /// Conditional to check if timer is active or
                    /// if the Brainstorm Session is running timeless.
                    /// This will prompt the view to add or remove the button
                    /// that adds Ideas.
                    if self.viewmodel.isTimerActive || self.viewmodel.timeless {
                        /// The Button responsible for adding new ideas
                        /// using the Apple TV remote.
                        Button(action: {
                            self.showKeyboard.toggle()
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "plus")
                                Spacer()
                                Text("Add")
                                Spacer()
                            }.frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2 )
                                .foregroundColor(Color("Black"))
                        }
                    }
                    
                    if showKeyboard {
                        TextField("Idea", text: self.$newIdea, onEditingChanged: {_ in}) {
                            self.viewmodel.addIdea(self.newIdea)
                            self.showKeyboard.toggle()
                            self.newIdea = ""
                        }.frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2 )
                        .foregroundColor(Color("Black"))
                    }
                }
                
                /// The Button responsible for moving forward to
                /// voting. Should alert the user before moving on.
                Button(action: {
                    /// Make it certain that the timer is no longer active.
                    self.viewmodel.brainstormTimer.invalidate()
                    self.shouldVote.toggle()
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: "checkmark.circle.fill")
                        Spacer()
                        Text("Vote")
                        Spacer()
                    }.frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2 )
                        .foregroundColor(Color("Black"))
                }
                
                /// The conditional responsible for creating the NavigationLink
                if self.shouldVote {
                    NavigationLink(destination: VotingView(viewmodel: VotingViewModel(ideas: viewmodel.convertIdeasArrayInMatrix(ideas: viewmodel.ideas), topic: viewmodel.topic)), isActive: $shouldVote) { EmptyView() }
                }
                
            }.frame(height: UIScreen.main.bounds.height * 0.15)
            Spacer()
        }.navigationBarBackButtonHidden(true).onExitCommand(perform: {})
            .background(Color.white)
            .edgesIgnoringSafeArea(.vertical)
    }
}
