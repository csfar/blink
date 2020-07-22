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
                Image(systemName: "timer")
                Spacer()
                Text("\(minutes)").bold()
                Spacer()
                Text("minutes")
            }.frame(width: 400, height: 50)
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
                Image("Icon").padding()
                Spacer()
                HStack {
                    if viewmodel.timer > 0 {
                        Text("\(viewmodel.timer) minutes")
                    } else {
                        Text("No time limit")
                    }
                    if !viewmodel.topic.isEmpty {
                        Text("\(viewmodel.topic)")
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        /// The Button responsible for setting a timer.
                        Button(action: {
                            self.selectingTimer.toggle()
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "clock")
                                Spacer()
                                Text("Set a timer").font(.headline)
                                Spacer()
                            }.frame(width: 400, height: 50)
                        }.frame(width: 400, height: 50).font(.headline)

                        if selectingTimer {
                            VStack() {
                                TimerRow(timer: $viewmodel.timer, minutes: 10).frame(height: 50).padding()
                                TimerRow(timer: $viewmodel.timer, minutes: 15).frame(height: 50).padding()
                                TimerRow(timer: $viewmodel.timer, minutes: 20).frame(height: 50).padding()
                            }.frame(width: 400).padding()
                        }
                    }.frame(width: 500)

                    VStack{
                        /// The Button responsible for setting a topic.
                        Button(action: {
                            self.selectingTopic.toggle()
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "textbox")
                                Spacer()
                                Text("Set a topic")
                                Spacer()
                            }.frame(width: 400, height: 50).font(.headline)
                        }
                        if selectingTopic {
                            TextField("Topic", text: $viewmodel.topic).frame(width: 400, height: 50)
                        }
                    }.frame(width: 500)

                    VStack {
                        if viewmodel.anyConnected || viewmodel.isHosting {
                            NavigationLink(destination: BrainstormingView(viewmodel: BrainstormingViewModel(topic: viewmodel.topic, timer: viewmodel.timer)),
                                           label: {
                                            HStack(alignment: .center) {
                                                Image(systemName: "play")
                                                Spacer()
                                                Text("Start session")
                                                Spacer()
                                            }.frame(width: 400, height: 50).font(.headline)
                            })

                        } else {
                            /// The Button responsible for starting the session.
                            Button(action: {
                                self.viewmodel.startHosting()
                            }) {
                                HStack(alignment: .center) {
                                    Image(systemName: "plus")
                                    Spacer()
                                    Text("Host a session")
                                    Spacer()
                                }.frame(width: 400, height: 50).font(.headline)
                            }
                        }
                    }.frame(width: 500)
                }
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewmodel: MenuViewModel())
    }
}
