//
//  AddIdeaSheetView.swift
//  Blink_iOS
//
//  Created by Artur Carneiro on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import SwiftUI

struct AddIdeaSheetView: View {
    @Binding var idea: String
    @Binding var isBeingShown: Bool

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Idea").font(.headline).bold().padding()
                TextField("Idea", text: $idea)
                    .navigationBarItems(trailing: Button(action: {
                        self.isBeingShown.toggle()
                    }, label: {
                        Text("Done")
                    })).padding()
                }.padding()
                .navigationBarTitle("Add idea", displayMode: .inline)
        }
    }
}
