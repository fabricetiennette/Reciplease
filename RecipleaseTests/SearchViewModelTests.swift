//
//  SearchViewModelTests.swift
//  RecipleaseTests
//
//  Created by Fabrice Etiennette on 15/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import XCTest
@testable import Reciplease

class SearchViewModelTests: XCTestCase {

    func testAddIngredient() {
        // Given:
        let searchViewModel = SearchViewModel(delegate: self as? SearchViewModeldelegate)
        let ingredient = "apple"
        let expect = expectation(description: "No error expected :D")

        // When:
        searchViewModel.reloadHandler = {
            XCTAssertEqual(searchViewModel.userIngredients, ["apple"])
            expect.fulfill()
        }
        searchViewModel.addIngredient(ingredient)
        searchViewModel.searchForRecipes()

        // Then:
        wait(for: [expect], timeout: 10)
    }

    func testAddIngredientErrorHandler() {
        // Given:
        let searchViewModel = SearchViewModel(delegate: self as? SearchViewModeldelegate)
        let userIngredient = searchViewModel.userIngredients
        let ingredient = "123"
        let expect = expectation(description: "Wait for error")

        // When:
        searchViewModel.errorHandler = { title, message in
            XCTAssertEqual(title, "Error")
            XCTAssertEqual(message, "Please enter a valid ingredient")
            XCTAssertEqual(userIngredient, [])
            expect.fulfill()
        }
        searchViewModel.addIngredient(ingredient)

        // Then:
        wait(for: [expect], timeout: 3)
    }

    func testUserIngredientMessageHandler() {
        // Given:
        let searchViewModel = SearchViewModel(delegate: self as? SearchViewModeldelegate)
        let ingredient = "123"
        let expect = expectation(description: "Wait for error")

        // When:
        searchViewModel.messageHandler = { text in
             XCTAssertEqual(text, "Ingredients missing 😢")
            expect.fulfill()
        }
        searchViewModel.userIngredients.append(ingredient)

        // Then:
        wait(for: [expect], timeout: 3)
    }
}
