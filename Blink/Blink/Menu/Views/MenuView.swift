//
//  MenuView.swift
//  Blink
//
//  Created by Artur Carneiro on 06/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct TimerRow: View {
    @Binding var timer: Int
    let minutes: Int

    var body: some View {
        Button(action: {
            self.timer = self.minutes
        }, label: {
            HStack {
                Text("\(minutes)").bold().frame(width: 100, height: 50)
                Text("minutes")
            }
        })
    }
}

/// Representation of the main menu. This view should be
/// the app's entry point.
struct MenuView: View {

    @ObservedObject var viewmodel: MenuViewModel

    @State var selectingTimer: Bool = false

    @State var selectingTopic: Bool = false
    
    /// The body of a `MenuView`.
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if viewmodel.timer > 0 {
                        Text("\(viewmodel.timer) minutes")
                    }
                    if !viewmodel.topic.isEmpty {
                        Text("\(viewmodel.topic)")
                    }
                }
                Spacer()
                HStack(alignment: .center) {

                    VStack {
                        /// The Button responsible for setting a timer.
                        Button(action: {
                            self.selectingTimer.toggle()
                        }) {
                            Image(systemName: "timer")
                        }.padding()

                        if selectingTimer {
                            VStack {
                                TimerRow(timer: $viewmodel.timer, minutes: 5)
                                TimerRow(timer: $viewmodel.timer, minutes: 10)
                                TimerRow(timer: $viewmodel.timer, minutes: 15)
                                TimerRow(timer: $viewmodel.timer, minutes: 20)
                            }.padding()
                        }
                    }

                    VStack{
                        /// The Button responsible for setting a topic.
                        Button(action: {
                            self.selectingTopic.toggle()
                        }) {
                            Image(systemName: "t.bubble")
                        }
                        if selectingTopic {
                            TextField("Topic", text: $viewmodel.topic)
                        }
                    }

                    VStack {
                        if viewmodel.anyConnected || viewmodel.isHosting {
                            NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel()),
                                           label: {Text("Start session")}).padding()

                        } else {
                            /// The Button responsible for starting the session.
                            Button(action: {
                                self.viewmodel.startHosting()
                            }) {
                                Image(systemName: "play")
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewmodel: MenuViewModel())
    }
}
