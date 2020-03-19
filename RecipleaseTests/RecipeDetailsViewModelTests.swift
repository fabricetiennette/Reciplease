//
//  RecipeDetailsViewModelTests.swift
//  RecipleaseTests
//
//  Created by Fabrice Etiennette on 13/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class RecipeDetailsViewModelTests: XCTestCase {

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

    func testNumberOfRowInSectionWhenSectionOne() {
        // Given:
        let recipeDetailsViewModel = RecipeDetailsViewModel(recipeSelected: recipeSelected, stack: coreDataManager)
        let sectionOne = 1

        // When:
        let numberOfRowsInSection = recipeDetailsViewModel.numberOfRowsInSection(sectionOne)

        // Then:
        XCTAssertEqual(numberOfRowsInSection, 1)
    }

    func testNumberOfRowInSectionWhenSectionThree() {
        // Given:
        let recipeDetailsViewModel = RecipeDetailsViewModel(recipeSelected: recipeSelected, stack: coreDataManager)
        let sectionThree = 3
        let numberOfIngredients = recipeSelected.ingredientLines.count

        // When:
        let numberOfRowsInSection = recipeDetailsViewModel.numberOfRowsInSection(sectionThree)

        // Then:
        XCTAssertEqual(numberOfRowsInSection, numberOfIngredients)
    }

    func testDeleteOneRecipeFromRecipeDetails() {
        // Given:
        let recipeDetailsViewModel = RecipeDetailsViewModel(recipeSelected: recipeSelected, stack: coreDataManager)
        coreDataManager.saveRecipeInStack(recipeSelected)
        let favoriteButton = UIBarButtonItem()
        let fill = UIImage(systemName: "heart.fill")
        favoriteButton.image = fill

        // When:
        coreDataManager.getRecipesFromStack { (result) in
            switch result {
            case .success(let recipe):
                XCTAssertEqual(recipe.count, 1)
            case .failure: break
            }
        }
        recipeDetailsViewModel.makeFavoriteOrNot(with: favoriteButton)

        // Then:
        coreDataManager.getRecipesFromStack { (result) in
            switch result {
            case .success(let recipe):
                XCTAssertEqual(recipe, [])
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testSaveOneRecipeFromRecipeDetails() {
        // Given:
        let recipeDetailsViewModel = RecipeDetailsViewModel(recipeSelected: recipeSelected, stack: coreDataManager)
        let favoriteButton = UIBarButtonItem()
        let notFill = UIImage(systemName: "heart")
        favoriteButton.image = notFill

        // When:
        coreDataManager.getRecipesFromStack { (result) in
            switch result {
            case .success(let recipe):
                XCTAssertEqual(recipe, [])
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        recipeDetailsViewModel.makeFavoriteOrNot(with: favoriteButton)

        // Then:
        coreDataManager.getRecipesFromStack { (result) in
            switch result {
            case .success(let recipe):
                XCTAssertEqual(recipe.count, 1)
            case .failure: break
            }
        }
    }

    func testSaveOneRecipeThatAlreadyExistFromRecipeDetails() {
        // Given:
        let recipeDetailsViewModel = RecipeDetailsViewModel(recipeSelected: recipeSelected, stack: coreDataManager)
        coreDataManager.saveRecipeInStack(recipeSelected)
        let favoriteButton = UIBarButtonItem()
        let fill = UIImage(systemName: "heart")
        favoriteButton.image = fill
        let expect = expectation(description: "Waiting for error")

        // When:
        coreDataManager.getRecipesFromStack { (result) in
            switch result {
            case .success(let recipe):
                XCTAssertEqual(recipe.count, 1)
            case .failure: break
            }
        }
        recipeDetailsViewModel.errorHandler = { title, message in
            XCTAssertEqual(title, "Error")
            XCTAssertEqual(message, "Already in your favorites")
            expect.fulfill()
        }
        recipeDetailsViewModel.makeFavoriteOrNot(with: favoriteButton)

        // Then:
        wait(for: [expect], timeout: 3)
    }
}
