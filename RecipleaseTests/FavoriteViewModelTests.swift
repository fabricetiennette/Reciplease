//
//  FavoriteViewModelTests.swift
//  RecipleaseTests
//
//  Created by Fabrice Etiennette on 15/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class FavoriteViewModelTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    let recipeSelected = SelectedRecipe(
        title: "Chicken Vesuvio",
        image: nil,
        source: "Serious Eats",
        url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
        yield: "4",
        ingredientLines: ["1/2 cup olive oil", "5 cloves garlic, peeled", "2 large russet potatoes, peeled and cut into chunks", "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)", "3/4 cup white wine", "3/4 cup chicken stock", "3 tablespoons chopped parsley", "1 tablespoon dried oregano", "Salt and pepper", "1 cup frozen peas, thawed"],
        calories: 4055.7632762010808,
        time: "60 MINUTES",
        ingredientChoose: "Chicken",
        isFavorite: false
    )

    func testSaveOneRecipeInStack() {
        // Given:
        let favoriteViewModel = FavoriteViewModel(delegate: self as? FavoriteViewModelDelegate, stack: coreDataManager)
        coreDataManager.saveRecipeInStack(recipeSelected)
        let expect = expectation(description: "wait for favorite")

        // When:
        favoriteViewModel.favoriteIsNotEmptyHandler = {
            XCTAssertEqual(favoriteViewModel.favorites.count, 1)
            XCTAssertEqual(favoriteViewModel.favorites.first?.title, "Chicken Vesuvio")
            expect.fulfill()
        }
        favoriteViewModel.updateFavorites()

        // Then:
        wait(for: [expect], timeout: 6)
    }

    func testUpdateFavoritesNothingSaved() {
        // Given:
        let favoriteViewModel = FavoriteViewModel(delegate: self as? FavoriteViewModelDelegate, stack: coreDataManager)
        let expect = expectation(description: "Wait for '[]'")

        // When:
        favoriteViewModel.favoritesIsEmptyHandler = {
            XCTAssertEqual(favoriteViewModel.favorites.count, 0)
            XCTAssertEqual(favoriteViewModel.favorites, [])
            expect.fulfill()
        }
        favoriteViewModel.updateFavorites()

        // Then:
        wait(for: [expect], timeout: 6)
    }

    func testDeleteOneRecipe() {
        // Given:
        let favoriteViewModel = FavoriteViewModel(delegate: self as? FavoriteViewModelDelegate, stack: coreDataManager)
        coreDataManager.saveRecipeInStack(recipeSelected)
        let expect = expectation(description: "Wait for '[]'")

        // When:
        favoriteViewModel.favoritesIsEmptyHandler = {
            XCTAssertEqual(favoriteViewModel.favorites.count, 0)
            XCTAssertEqual(favoriteViewModel.favorites, [])
            expect.fulfill()
        }
        coreDataManager.deleteOneRecipeInStack(self.recipeSelected)
        favoriteViewModel.updateFavorites()

        // Then:
        wait(for: [expect], timeout: 6)
    }

    func testIfRecipeSaveTwiceWhenTrue() {
        // Given:
        coreDataManager.saveRecipeInStack(recipeSelected)

        // When:
        let recipe = coreDataManager.isEntityExist(recipeSelected.title!)

        // Then:
        XCTAssertTrue(recipe)
    }

    func testIfRecipeExistTwiceWhenFalse() {
        // Given:
        let recipeSelected = SelectedRecipe(
            title: "chicken tikka",
            image: nil,
            source: "Serious Eats",
            url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
            yield: "4",
            ingredientLines: ["1/2 cup olive oil", "5 cloves garlic, peeled", "2 large russet potatoes, peeled and cut into chunks", "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)", "3/4 cup white wine", "3/4 cup chicken stock", "3 tablespoons chopped parsley", "1 tablespoon dried oregano", "Salt and pepper", "1 cup frozen peas, thawed"],
            calories: 4055.7632762010808,
            time: "60 MINUTES",
            ingredientChoose: "Chicken",
            isFavorite: false
        )
        coreDataManager.saveRecipeInStack(recipeSelected)

        // When:
        let recipe = coreDataManager.isEntityExist(self.recipeSelected.title!)

        // Then:
        XCTAssertFalse(recipe)
    }

    func testSaveImage() {
        // Given:
        var imageData = UIImage()
        if let url = URL(string: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg") {
            if let data = try? Data(contentsOf: url) {
                imageData = UIImage(data: data)!
            }
        }

        let recipeSelected = SelectedRecipe(
            title: "chicken tikka",
            image: imageData,
            source: nil,
            url: nil,
            yield: "4",
            ingredientLines: [nil],
            calories: nil,
            time: "60 MINUTES",
            ingredientChoose: "Chicken",
            isFavorite: false
        )
        let favoriteViewModel = FavoriteViewModel(delegate: self as? FavoriteViewModelDelegate, stack: coreDataManager)
        coreDataManager.saveRecipeInStack(recipeSelected)
        let expect = expectation(description: "wait for favorite")

        // When:
        favoriteViewModel.favoriteIsNotEmptyHandler = {
            XCTAssertNotNil(favoriteViewModel.favorites.first?.image)
            XCTAssertNil(favoriteViewModel.favorites.first?.source)
            XCTAssertEqual(favoriteViewModel.favorites.count, 1)
            expect.fulfill()
        }
        favoriteViewModel.updateFavorites()

        // Then:
        wait(for: [expect], timeout: 6)
    }
}
