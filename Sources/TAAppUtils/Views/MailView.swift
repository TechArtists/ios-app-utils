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

public struct MailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    public init(result: Binding<Result<MFMailComposeResult, Error>?>) {
        self._result = result
    }

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var dismiss: DismissAction
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(dismiss: DismissAction, result: Binding<Result<MFMailComposeResult, Error>?>) {
            self.dismiss = dismiss
            _result = result
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
            
            dismiss()
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss, result: $result)
    }

    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients([""])
        mailComposeVC.mailComposeDelegate = context.coordinator
        return mailComposeVC
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }
}
