//
//  RecipleaseUITests.swift
//  RecipleaseUITests
//
//  Created by Fabrice Etiennette on 17/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import XCTest

class RecipleaseUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTabBar() {
        app.tabBars.buttons["Favorites"].tap()
        app.tabBars.buttons["Search"].tap()
    }

    func testTapAddWhenTextFieldIsEmpty() {
        let button = app.buttons.element(matching: .button, identifier: "Add")
        button.tap()
        app.alerts["Error"].buttons["OK"].tap()
    }

    func testTapViewEndEditing() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        textField.tap()
        textField.typeText("Apple")
        app.tap()
    }

    func testAddIngredient() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let button = app.buttons.element(matching: .button, identifier: "Add")
        textField.tap()
        textField.typeText("Apple")
        button.tap()
    }

    func testAddIngredientAndClear() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let clearButton = app.buttons.element(matching: .button, identifier: "Clear")
        textField.tap()
        textField.typeText("Apple")
        addButton.tap()
        clearButton.tap()
    }

    func testSwipeToDeleteIngredient() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let tablesQuery = app.tables.cells
        textField.tap()
        textField.typeText("Apple")
        addButton.tap()
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
    }

    func testEnterAndInvalideIngredient() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        textField.tap()
        textField.typeText("123")
        addButton.tap()
        app.alerts["Error"].buttons["OK"].tap()
        XCTAssertEqual(textField.placeholderValue, "What's in your fridge ?")
    }

    func testSearchForRecipesAndBackToSearchPage() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let searchButton = app.buttons.element(matching: .button, identifier: "Tap to search for recipes")
        let backButton = app.navigationBars.buttons.element(boundBy: 0)

        textField.tap()
        textField.typeText("Chicken")
        addButton.tap()
        searchButton.tap()
        sleep(6)
        app.swipeUp()
        app.swipeDown()
        backButton.tap()
    }

    func testSearchAndSelectOneRecipe() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let searchButton = app.buttons.element(matching: .button, identifier: "Tap to search for recipes")
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        let myTable = app.tables.matching(identifier: "recipeListId")
        let cell = myTable.cells.element(matching: .cell, identifier: "recipeListCell_1")

        textField.tap()
        textField.typeText("Chicken")
        addButton.tap()
        searchButton.tap()
        sleep(6)
        XCTAssertEqual(myTable.cells.count, 10)
        cell.tap()
        app.swipeUp()
        app.swipeDown()
        backButton.tap()
        backButton.tap()
    }

    func testSearchAndSelectOneRecipeAndTapForWebPage() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let searchButton = app.buttons.element(matching: .button, identifier: "Tap to search for recipes")
        let getDirectionButton = app.buttons.element(matching: .button, identifier: "Get direction")
        let doneButton = app.buttons.element(matching: .button, identifier: "Done")
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        let myTable = app.tables.matching(identifier: "recipeListId")
        let cell = myTable.cells.element(matching: .cell, identifier: "recipeListCell_2")

        textField.tap()
        textField.typeText("Chicken")
        addButton.tap()
        searchButton.tap()
        sleep(6)
        cell.tap()
        app.swipeUp()
        app.swipeDown()
        getDirectionButton.tap()
        sleep(3)
        doneButton.tap()
        backButton.tap()
        backButton.tap()
    }

    func testAddOneRecipeToFavorite() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let searchButton = app.buttons.element(matching: .button, identifier: "Tap to search for recipes")
        let listTable = app.tables.matching(identifier: "recipeListId")
        let favTable = app.tables.matching(identifier: "favoritesTableView")
        let cell = listTable.cells.element(matching: .cell, identifier: "recipeListCell_2")
        let favoriteCell = favTable.cells.element(matching: .cell, identifier: "recipeFavorite_0")
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        let favoriteButton = app.buttons["favoriteBarButton"]

        app.tabBars.buttons["Favorites"].tap()
        for _ in 0..<favTable.cells.count {
            favoriteCell.tap()
            favoriteButton.tap()
            backButton.tap()
        }
        XCTAssertEqual(favTable.cells.count, 0)
        app.tabBars.buttons["Search"].tap()
        textField.tap()
        textField.typeText("Chicken")
        addButton.tap()
        searchButton.tap()
        sleep(6)
        cell.tap()
        favoriteButton.tap()
        app.tabBars.buttons["Favorites"].tap()
        XCTAssertEqual(favTable.cells.count, 1)
    }

    func testIfCanHaveTwoSimilarRecipe() {
        let textField = app.textFields.element(matching: .textField, identifier: "IngredientTextField")
        let addButton = app.buttons.element(matching: .button, identifier: "Add")
        let searchButton = app.buttons.element(matching: .button, identifier: "Tap to search for recipes")
        let listTable = app.tables.matching(identifier: "recipeListId")
        let favTable = app.tables.matching(identifier: "favoritesTableView")
        let cell = listTable.cells.element(matching: .cell, identifier: "recipeListCell_2")
        let favoriteCell = favTable.cells.element(matching: .cell, identifier: "recipeFavorite_0")
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        let favoriteButton = app.buttons["favoriteBarButton"]

        app.tabBars.buttons["Favorites"].tap()
        for _ in 0..<favTable.cells.count {
            favoriteCell.tap()
            favoriteButton.tap()
            backButton.tap()
        }
        XCTAssertEqual(favTable.cells.count, 0)

        app.tabBars.buttons["Search"].tap()
        textField.tap()
        textField.typeText("Chicken")
        addButton.tap()
        searchButton.tap()
        sleep(6)
        cell.tap()
        favoriteButton.tap()
        app.tabBars.buttons["Favorites"].tap()
        XCTAssertEqual(favTable.cells.count, 1)
        app.tabBars.buttons["Search"].tap()
        backButton.tap()
        cell.tap()
        favoriteButton.tap()
        app.alerts["Error"].buttons["OK"].tap()
    }
}
