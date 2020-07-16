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

    @State var ideas: [String] = [String]()

    var body: some View {
        List {
            ForEach(0 ..< viewmodel.ideas.count) { index in
                HStack(alignment: .center) {
                    Text("\(self.viewmodel.ideas[index].content)")
                    Spacer()
                    if self.viewmodel.ideas[index].isSelected {
                        Button(action: {
                            self.viewmodel.ideas[index].isSelected.toggle()
                        }, label: {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(Color.red)
                        })
                    } else {
                        Button(action: {
                            self.viewmodel.ideas[index].isSelected.toggle()
                        }, label: {
                            Image(systemName: "circle").foregroundColor(Color.yellow)
                        })
                    }
                }
            }
        }.navigationBarTitle("\(viewmodel.topic)")
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView(viewmodel: VotingViewModel())
    }
}
