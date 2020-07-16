//
//  Idea.swift
//  Blink_iOS
//
//  Created by Victor Falcetta do Nascimento on 14/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

struct Idea: Identifiable, Codable, Hashable {
    
    let id: UUID = UUID()
    var content: String
    var isSelected: Bool = false
    var votes: Int = 0
}
