//
//  UIImageView+.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 19/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

extension UIImageView {

    func getImage(from myUrl: String) {
        guard let url = URL(string: myUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let myData = data, let image = UIImage(data: myData) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
