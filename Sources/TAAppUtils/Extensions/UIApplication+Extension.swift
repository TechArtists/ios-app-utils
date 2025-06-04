//
//  UIApplication+Extension.swift
//  TAAppUtils
//
//  Created by Robert Tataru on 04.06.2025.
//

import UIKit

public extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var rootController: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }
        
        var root = windowScene.windows.filter { $0.isKeyWindow }.first?.rootViewController
        
        while let presentedViewController = root?.presentedViewController {
            root = presentedViewController
        }
        return root
    }
    
    func presentAlert(
        title: String,
        subTitle: String,
        primaryAction: UIAlertAction,
        secondaryAction: UIAlertAction? = nil
    ) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
            alertController.addAction(primaryAction)
            if let secondary = secondaryAction {
                alertController.addAction(secondary)
            }
            self.rootController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentAccessDeniedAlert(
        accessType: String,
        message: String
    ) {
        let settingsURL = URL(string: UIApplication.openSettingsURLString)!
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )

        UIApplication.shared.presentAlert(
            title: "\(accessType) Access",
            subTitle: message,
            primaryAction: okAction,
            secondaryAction: cancelAction
        )
    }
}

