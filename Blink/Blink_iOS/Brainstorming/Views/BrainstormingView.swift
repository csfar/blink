//
//  BrainstormingView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct BrainstormingView: View {
    @State var _testArr: [String] = [String]()

    @State var newIdea: String = ""
    @State var showAddIdeaSheet: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(_testArr, id: \.self) { idea in
                    Text("\(idea)")
                }
            }.navigationBarTitle("Ideas")
                .navigationBarItems(trailing: Button(action: {
                    self.showAddIdeaSheet.toggle()
                }, label: { Image(systemName: "plus") })
                    .sheet(isPresented: $showAddIdeaSheet, content: {
                        AddIdeaSheetView(idea: self.$newIdea, isBeingShown: self.$showAddIdeaSheet)
                            .onDisappear(perform: {
                                if !self.newIdea.isEmpty {
                                    self._testArr.append(self.newIdea)
                                }
                                self.newIdea = ""
                            })
                    })
            )
        }
    }
}

struct BrainstormingView_Previews: PreviewProvider {
    static var previews: some View {
        BrainstormingView()
    }
}
