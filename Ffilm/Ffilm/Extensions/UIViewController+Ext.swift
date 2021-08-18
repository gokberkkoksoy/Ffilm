//
//  UIViewController+Ext.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import UIKit

enum AlertType {
    case error, notification
}

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String, alertType: AlertType) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                if alertType == .error { self.dismiss(animated: true) }
            }))
            self.present(alertVC, animated: true)
        }
    }
}
