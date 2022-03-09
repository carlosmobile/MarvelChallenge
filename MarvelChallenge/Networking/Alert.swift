//
//  Alert.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 9/3/22.
//

import UIKit

struct Alert {
    static func present(_ message: String, actions: [Alert.Action], from controller: UIViewController) {

        let alertTitle = "errorTitle".localized
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action.alertAction)
        }

        controller.present(alertController, animated: true, completion: nil)
    }
}

extension Alert {
    enum Action {
        case ok(handler: (() -> Void)?)
        case close

        private var title: String {
            switch self {
            case .ok:
                return "ok".localized
            case .close:
                return "close".localized
            }
        }

        private var handler: (() -> Void)? {
            switch self {
            case .ok(let handler):
                return handler
            case .close:
                return nil
            }
        }

        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: .default, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}

