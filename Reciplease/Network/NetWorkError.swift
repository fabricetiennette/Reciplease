//
//  NetWorkError.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 26/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

enum NetWorkError: Error {
    case badUrl
    case noData
    case jsonError
}
