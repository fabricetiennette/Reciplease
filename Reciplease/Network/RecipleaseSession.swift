//
//  RecipleaseSession.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 16/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipleaseClientSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

final class RecipleaseSession: RecipleaseClientSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url)
            .responseJSON { responseData in
            callBack(responseData)
        }
    }
}
