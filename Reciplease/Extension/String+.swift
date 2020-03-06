//
//  String+.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 28/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

extension String {
    func hasSpecialCharacters() -> Bool {
        let set = CharacterSet(
            charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"
        )
        if self.rangeOfCharacter(from: set.inverted) != nil || self.isEmpty {
            return true
        } else {
            return false
        }
    }
}
