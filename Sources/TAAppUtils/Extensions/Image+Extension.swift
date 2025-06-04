//
//  Image+Extension.swift
//  TAAppUtils
//
//  Created by Robert Tataru on 04.06.2025.
//


import SwiftUI

public extension Image {
    init?(adaptiveName name: String) {
        if let systemImage = UIImage(systemName: name) {
            self = Image(uiImage: systemImage)
        } else if let assetImage = UIImage(named: name) {
            self = Image(uiImage: assetImage)
        } else {
            return nil
        }
    }
}

public extension String {
    var isSFSymbolImage: Bool {
        if let _ = UIImage(systemName: self) {
            return true
        }
        
        return false
    }
}
