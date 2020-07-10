//
//  VotingViewModelTests.swift
//  BlinkTests
//
//  Created by Edgar Sgroi on 10/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import XCTest
@testable import Blink

class VotingViewModelTests: XCTestCase {

    func testCountVotes() {
        let viewModel = VotingViewModel()
        let ideas = ["preved", "poka", "hola", "yo"]
        let votes = ["preved", "hola", "poka", "hola", "poka", "hola"]
        
        XCTAssertFalse(ideas.isEmpty)
        XCTAssertFalse(votes.isEmpty)
        
        let result = viewModel.countVotes(votes: votes, ideas: ideas)
        XCTAssertFalse(result.isEmpty)
        let expectedResult = [(key: "hola", value: 3), (key: "poka", value: 2), (key: "preved", value: 1), (key: "yo", value: 0)]
        for index in 0..<expectedResult.count {
            XCTAssertEqual(expectedResult[index].value, result[index].value)
        }
    }

}
