//
//  UIViewController+Ext.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import UIKit
import SafariServices
import SPAlert
import SPIndicator

enum AlertType {
    case error, notification, warning
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
    
    func presentAlert(title: String, type: AlertType) {
        DispatchQueue.main.async {
            if type == .notification {
                let alertView = SPAlertView(title: title, preset: .done)
                alertView.present(duration: 0.75)
            } else if type == .warning {
                let alertView = SPAlertView(title: title, preset: .error)
                alertView.present(duration: 0.75)
            }
        }
    }
    
    func presentErrorAlert(title: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { SPAlert.present(message: title, haptic: .error, completion: completion) }
    }
    
    func presentIndicator(with title: String) {
        DispatchQueue.main.async { SPIndicator.present(title: title, preset: .error, from: .bottom) }
    }
    
    func presentSafariVC(with url: URL?)  {
        if let url = url {
            let safariVC = SFSafariViewController(url: url)
            modalPresentationStyle = .fullScreen
            present(safariVC, animated: true)
        }
    }
}
