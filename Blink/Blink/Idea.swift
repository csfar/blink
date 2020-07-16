//
//  Idea.swift
//  Blink
//
//  Created by Artur Carneiro on 16/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

struct Idea: Identifiable, Codable, Hashable {

    let id: UUID = UUID()
    var content: String
    var isSelected: Bool = false
    var votes: Int = 0
}
