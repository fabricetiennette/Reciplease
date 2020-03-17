//
//  RecipeListViewModelTests.swift
//  RecipleaseTests
//
//  Created by Fabrice Etiennette on 15/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeListViewModelTests: XCTestCase {

    func testGetRecipesWithSuccess() {
        // Given:
        let resipleaseClient = RecipleaseClient(
            session: SessionFake(
                data: FakeResponseData.RecipesCorrectData,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        let ingredient = "chicken"
        let recipeListeViewModel = RecipeListViewModel(
            ingredient: ingredient,
            delegate: self as? RecipeListViewModelDelegate,
            resipleaseClient: resipleaseClient
        )
        let expect = expectation(description: "wait for 10 recipes")

        // When:
        recipeListeViewModel.reloadHandler = {
            XCTAssertEqual(recipeListeViewModel.recipe.count, 10)
            expect.fulfill()
        }
        recipeListeViewModel.getRecipes()

        // Then:
        wait(for: [expect], timeout: 3)
    }

    func testGetRecipesWithResponseError() {
        // Given:
        let resipleaseClient = RecipleaseClient(
            session: SessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseKO,
                error: nil)
        )
        let ingredient = "chicken"
        let recipeListeViewModel = RecipeListViewModel(
            ingredient: ingredient,
            delegate: self as? RecipeListViewModelDelegate,
            resipleaseClient: resipleaseClient
        )
        let expect = expectation(description: "wait for error")

        // When:
        recipeListeViewModel.errorHandler = { title, message in
            XCTAssertEqual(title, "Error")
            XCTAssertEqual(message, "Cannot get recipes for the moment")
            expect.fulfill()
        }
        recipeListeViewModel.getRecipes()

        // Then:
        wait(for: [expect], timeout: 3)
    }

    func testGetRecipesWithJsonError() {
        // Given:
        let resipleaseClient = RecipleaseClient(
            session: SessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil)
        )
        let ingredient = "chicken"
        let recipeListeViewModel = RecipeListViewModel(
            ingredient: ingredient,
            delegate: self as? RecipeListViewModelDelegate,
            resipleaseClient: resipleaseClient
        )
        let expect = expectation(description: "wait for error")

        // When:
        recipeListeViewModel.errorHandler = { title, message in
            XCTAssertEqual(title, "Error")
            XCTAssertEqual(message, "Cannot get recipes for the moment")
            expect.fulfill()
        }
        recipeListeViewModel.getRecipes()

        // Then:
        wait(for: [expect], timeout: 3)
    }

    func testGetRecipesWithDataError() {
        // Given:
        let resipleaseClient = RecipleaseClient(
            session: SessionFake(
                data: nil,
                response: nil,
                error: FakeResponseData.errorRecipes)
        )
        let ingredient = "chicken"
        let recipeListeViewModel = RecipeListViewModel(
            ingredient: ingredient,
            delegate: self as? RecipeListViewModelDelegate,
            resipleaseClient: resipleaseClient
        )
        let expect = expectation(description: "wait for error")

        // When:
        recipeListeViewModel.errorHandler = { title, message in
            XCTAssertEqual(title, "Error")
            XCTAssertEqual(message, "Cannot get recipes for the moment")
            expect.fulfill()
        }
        recipeListeViewModel.getRecipes()

        // Then:
        wait(for: [expect], timeout: 3)
    }
}
