//
//  SessionFake.swift
//  Baluchon
//
//  Created by Fabrice Etiennette on 15/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class SessionFake: RecipleaseClientSession {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = response
        let data = self.data
        let error =  self.error
        let result = Request.serializeResponseJSON(
            options: .allowFragments,
            response: httpResponse,
            data: data,
            error: error
        )
        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
        callBack(
            DataResponse(
                request: urlRequest,
                response: httpResponse,
                data: data,
                result: result
            )
        )
    }
}
