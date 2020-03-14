//
//  RecipleaseClient.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 26/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Alamofire

struct RecipleaseClient {

    private let session: Session
    private let baseURL = "https://api.edamam.com/search?"
    private let appId = "13a8cfe3"
    private let appKey = "52ba666b724b469493e5b13708898d64"

    init(session: Session = Session.default) {
        self.session = session
    }

    // MARK: - getRecipesFromEdamam

    func getRecipesFromEdamam(
        with ingredients: String,
        callback: @escaping (Result<RecipeData, Error>) -> Void
    ) {
        guard let recipleaseURL = URL(string: "\(baseURL)q=\(ingredients)&app_id=\(appId)&app_key=\(appKey)") else { return }

        let request = session.request(recipleaseURL)
        request.responseDecodable(of: RecipeData.self) { (response) in
            guard let data = response.data else {
                callback(.failure(NetWorkError.noData))
                return
            }

            guard response.response?.statusCode == 200 else {
                callback(.failure(NetWorkError.badUrl))
                return
            }

            do {
                let recipe = try JSONDecoder().decode(RecipeData.self, from: data)
                callback(.success(recipe))
            } catch {
                callback(.failure(NetWorkError.jsonError))
            }
        }
    }
}
