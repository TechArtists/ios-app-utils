//
//  MailView.swift
//  TAAppUtils
//
//  Created by Robert Tataru on 04.06.2025.
//


import UIKit
import SwiftUI
import MessageUI

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var dismiss: DismissAction
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(dismiss: DismissAction, result: Binding<Result<MFMailComposeResult, Error>?>) {
            self.dismiss = dismiss
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
            
            dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss, result: $result)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients([""])
        mailComposeVC.mailComposeDelegate = context.coordinator
        return mailComposeVC
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }
}
