//
//  SafariView.swift
//  TAAppUtils
//
//  Created by Robert Tataru on 04.06.2025.
//

import SwiftUI
import SafariServices

public struct SafariView: UIViewControllerRepresentable {
    let url: URL

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }

}
