//
//  CustomAlert+UIViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

extension UIViewController {

    func showCustomAlertWith(okButtonAction: (() ->())? = {}, title: String, message: String) {
        let alertViewController = CustomAlertViewController.init(nibName: "CustomAlertViewController", bundle: nil)
        alertViewController.alertTitle = title
        alertViewController.alertMessage = message
        alertViewController.okButtonAct = okButtonAction

        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overCurrentContext
        self.present(alertViewController, animated: true, completion: nil)
    }
}
