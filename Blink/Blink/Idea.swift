//
//  Idea.swift
//  Blink
//
//  Created by Artur Carneiro on 16/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

struct Idea: Identifiable {

    let id: UUID = UUID()
    var content: String
    var isSelected: Bool = false
    var votes: Int = 0
}

extension Idea: Codable {}
extension Idea: Hashable {}
extension Idea: Equatable {
    static func ==(lhs: Idea, rhs: Idea) -> Bool {
        return lhs.id == rhs.id && lhs.content == rhs.content && lhs.isSelected == rhs.isSelected && lhs.votes == rhs.votes
    }
}
