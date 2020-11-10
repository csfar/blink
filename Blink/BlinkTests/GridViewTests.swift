//
//  GridViewTests.swift
//  BlinkTests
//
//  Created by Edgar Sgroi on 29/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import XCTest
@testable import Blink

class GridViewTests: XCTestCase {
    
    func testMakeGridList() {
        let ideas = [Idea(content: "Idea 1"), Idea(content: "Idea 2"), Idea(content: "Idea 3"),
                     Idea(content: "Idea 4"), Idea(content: "Idea 5"), Idea(content: "Idea 6"),
                     Idea(content: "Idea 7"), Idea(content: "Idea 8"), Idea(content: "Idea 9"),
                     Idea(content: "Idea 10"), Idea(content: "Idea 11"), Idea(content: "Idea 12"),
                     Idea(content: "Idea 13"), Idea(content: "Idea 14"), Idea(content: "Idea 15"),
                     Idea(content: "Idea 16"), Idea(content: "Idea 16.5"), Idea(content: "Idea 17"),
                     Idea(content: "Idea 18"), Idea(content: "Idea 19"), Idea(content: "Idea 20"),
                     Idea(content: "Idea 21"), Idea(content: "Idea 22"), Idea(content: "Idea 23"),
                     Idea(content: "Idea 24"), Idea(content: "Idea 25"), Idea(content: "Idea 26"),
                     Idea(content: "Idea 27"), Idea(content: "Idea 28"), Idea(content: "Idea 29"),
                     Idea(content: "Idea 30")]
        
        let formattedIdeas = makeGridList(with: ideas)
        print(formattedIdeas)
        print(formattedIdeas[0].count)
        
    }
    
    func makeGridList(with ideas: [Idea]) -> [[Idea]] {
        var gridList: [[Idea]] = []
        var row = ""
        var rowArr = [Idea]()
        for idea in ideas {
            let aux = row.isEmpty ? "\(idea.content)" : "\(row) \(idea.content)"
            if aux.count < 100 {
                row = aux
                rowArr.append(idea)
            } else {
                gridList.append(rowArr)
                row = ""
                rowArr = []
            }
        }
        return gridList
    }
}
