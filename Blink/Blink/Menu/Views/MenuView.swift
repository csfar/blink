//
//  MenuView.swift
//  Blink
//
//  Created by Artur Carneiro on 06/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

/// Representation of the main menu. This view should be
/// the app's entry point.
struct MenuView: View {
    
    @ObservedObject var viewmodel: MenuViewModel

    @State var shouldStart: Bool = false

    @State var timer: String = ""
    
    /// The body of a `MenuView`.
    var body: some View {
        NavigationView {
             HStack(spacing: 0) {
                       VStack(alignment: .center) {
                        Spacer(minLength: UIScreen.main.bounds.height * 0.05)
                        HStack {
                            Image("new-tvos-icon-front-large")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.height * 0.1)
                            Spacer()
                            Spacer()
                        }
                        .background(Color("Accent"))
                           Spacer()

                        Text("\(timer) min")
                               .font(.system(size: 225, weight: .bold, design: .rounded))
                               .foregroundColor(Color("Background"))
                               .frame(width: UIScreen.main.bounds.width/2 * 0.8, height: UIScreen.main.bounds.height * 0.32)

                        TextField("Set the amount of minutes", text: $timer)
                               .keyboardType(.numberPad)
                               .padding()
                               .frame(width: UIScreen.main.bounds.width/2 * 0.8)
                               .foregroundColor(Color("Black"))

                        Spacer(minLength: UIScreen.main.bounds.height * 0.245)
                       }
                       .frame(width: UIScreen.main.bounds.width/2)
                       .background(Color("Accent"))


                       VStack(alignment: .leading) {
                           Spacer()

                        Text("Topic: \(viewmodel.topic)")
                               .font(.system(size: 100, weight: .bold, design: .rounded))
                               .foregroundColor(Color("Accent"))
                               .multilineTextAlignment(.leading)
                               .lineLimit(nil)
                               .frame(width: UIScreen.main.bounds.width/2 * 0.8, height: UIScreen.main.bounds.height * 0.5)


                        HStack(alignment: .top) {
                            TextField("Set a topic", text: $viewmodel.topic)
                                   .keyboardType(.default)
                                   .padding()
                                   .frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2 )
                                   .foregroundColor(Color("Black"))

                               Button(action: {
                                self.shouldStart.toggle()
                               }, label: {

                                   HStack {
                                       Image(systemName: "play.fill")

                                       Text("Start session")
                                           .font(.system(.body, design: .rounded))

                                   }.foregroundColor(Color("Black"))
                                
                               }).frame(width: (UIScreen.main.bounds.width/2 * 0.8) / 2 )
                            
                        }
                        
                        Spacer()
                        
                       }
                       .frame(width: UIScreen.main.bounds.width/2)
                       .background(Color("Background"))
                if shouldStart == true {
                    NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel(topic: viewmodel.topic, timer: Int(timer) ?? 0)), isActive: self.$shouldStart) { EmptyView() }
                }
             }
                .edgesIgnoringSafeArea(.vertical)
        .navigationBarBackButtonHidden(true).onExitCommand(perform: {})
        }
    }
}
