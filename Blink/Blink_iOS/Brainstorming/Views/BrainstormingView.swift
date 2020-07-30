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
    /// Bool type variable that controls the showing of the alert box.
    /// This alert box is a placeholder feedback. It'll only be used as long
    /// as there isn't a more suitable option.
    @State private var showIdeaFeedback: Bool = false
    /// Bool type variable that refreshes the placeholder text once
    /// an idea is sent through the press of the button.
    @State private var refreshPlaceholder: Bool = false
    /// Binding that has the reference for the State var on the MenuView
    @Binding var hasStarted: Bool


    var body: some View {
        VStack {
            Spacer()
            Text("Brainstorming")
                .foregroundColor(Color("Background"))
                .font(.system(.title, design: .rounded))
                .bold()
                .frame(height: UIScreen.main.bounds.height * 0.2)

            TextField("Idea" + (refreshPlaceholder ? "" : " "), text: $newIdea)
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding()
                .background(Color("Background"))
                .cornerRadius(15)
                .shadow(radius: 5, y: 15)
                .foregroundColor(Color("Accent"))
            
            if !newIdea.isEmpty {
                Spacer()
                Button(action: {
                    self.viewmodel.sendIdea(self.newIdea)
                    self.showIdeaFeedback.toggle()
                    
                }) {
                    Text("Send")
                        .font(.system(.headline, design: .rounded))
                        .bold()
                        .foregroundColor(Color("Accent"))
                }
                .frame(width: UIScreen.main.bounds.width * 0.4,
                       height: UIScreen.main.bounds.height * 0.08)
                .background(Color("Background"))
                .cornerRadius(15)
                .shadow(radius: 5, y: 15)
                    /// Alert that is created to serve as feedback to inform the user
                    /// that an idea was sent to the TV.
                    .alert(isPresented: $showIdeaFeedback) {
                        Alert(title: Text("Idea Sent!"), message: Text("Your idea was sent to the TV."), dismissButton: .default(Text("Ok!")) {
                            /// Here the TextField is cleared and the placeholder is refreshed.
                            self.newIdea = ""
                            self.refreshPlaceholder.toggle()
                        })
                }
            }

            Spacer(minLength: UIScreen.main.bounds.height * 0.5)
            
            if viewmodel.shouldVote {
                NavigationLink(destination: VotingView(viewmodel: VotingViewModel(ideas: self.viewmodel.ideas), hasStarted: $hasStarted), isActive: self.$viewmodel.shouldVote, label: {EmptyView().navigationBarItems(trailing: Text("Vote"))}).isDetailLink(false)
            }
        }.navigationBarBackButtonHidden(true)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("Accent"))
            .edgesIgnoringSafeArea(.bottom)
    }
}

