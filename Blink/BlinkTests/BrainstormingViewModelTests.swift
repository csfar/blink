//
//  BrainstormingViewModelTests.swift
//  BlinkTests
//
//  Created by Edgar Sgroi on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import XCTest
@testable import Blink

class BrainstormingViewModelTests: XCTestCase {

    func testConvertIdeasArrayInMatrix() {
        let viewModel = BrainstormingViewModel()
        let icecreams = ["Napolitano", "Milho", "Creme", "Chocolate", "Morango", "Limão", "Banana", "Açaí", "Chiclete"]
        
        XCTAssertFalse(icecreams.isEmpty)
        
        let resultIcecreams = viewModel.convertIdeasArrayInMatrix(ideas: icecreams)
        XCTAssertFalse(resultIcecreams.isEmpty)
        
        let expectedResultIcecreams = [["Napolitano", "Milho", "Creme"], ["Chocolate", "Morango", "Limão"], ["Banana", "Açaí", "Chiclete"]]
        for indexRow in 0..<expectedResultIcecreams.count {
            for indexIdea in 0..<expectedResultIcecreams[indexRow].count {
                XCTAssertEqual(expectedResultIcecreams[indexRow][indexIdea], resultIcecreams[indexRow][indexIdea])
            }
        }
        
        let pizzas = ["Calabresa", "Napolitana", "Portuguesa", "Berinjela", "Toscana"]
        
        XCTAssertFalse(pizzas.isEmpty)
        
        let resultPizzas = viewModel.convertIdeasArrayInMatrix(ideas: pizzas)
        XCTAssertFalse(resultPizzas.isEmpty)
        
        let expectedResultPizzas = [["Calabresa", "Napolitana", "Portuguesa"], ["Berinjela", "Toscana"]]
        for indexRow in 0..<expectedResultPizzas.count {
            for indexIdea in 0..<expectedResultPizzas[indexRow].count {
                XCTAssertEqual(expectedResultPizzas[indexRow][indexIdea], resultPizzas[indexRow][indexIdea])
            }
        }
    }
}
