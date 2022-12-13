//
//  Alert.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 09.12.2022.
//

import UIKit

extension UIViewController {
    func showAlertWithOneButton(message: String, title: String = "", okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okActionHandler)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTwoButtons(message: String, title: String = "", okActionHandler: ((UIAlertAction) -> Void)? = nil, cancelActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okActionHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelActionHandler)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
