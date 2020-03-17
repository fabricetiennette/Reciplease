// swiftlint:disable force_try
//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Fabrice Etiennette on 16/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

class FakeResponseData {

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
        )!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil
        )!

    static let incorrectData = "erreur".data(using: .utf8)!

    // Reciplease
    class RecipesError: Error {}
    static let errorRecipes = RecipesError()
    static var RecipesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipesHits", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
}
