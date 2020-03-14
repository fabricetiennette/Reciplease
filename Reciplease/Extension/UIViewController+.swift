//
//  UIViewController+.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 27/02/2020.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlertWithDismissAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {(_) in
            self.dismissMe(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func dismissMe(animated: Bool, completion: (() -> Void)?) {
        var count = 0
        if let myCount = self.navigationController?.viewControllers.count {
            count = myCount
        }
        if count > 1 {
            self.navigationController?.popViewController(animated: animated)
            if let handler = completion {
                handler()
            }
        } else {
            dismiss(animated: animated, completion: completion)
        }
    }
}
