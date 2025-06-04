//
//  ScreenDimensions.swift
//  TAAppUtils
//
//  Created by Robert Tataru on 04.06.2025.
//


import UIKit

/// Utility for accessing screen and device-specific properties.
enum ScreenDimensions {
    // MARK: - Screen Properties
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    // MARK: - Device Heights
    static let iPhone8Height: CGFloat = 667.0
    static let iPhoneXHeight: CGFloat = 812.0
    static let iPhone11ProHeight: CGFloat = 896.0
    static let iPhone12ProHeight: CGFloat = 844.0
    static let iPhone14ProMaxHeight: CGFloat = 932.0

    // MARK: - Device Widths (for completeness)
    static let iPhone8Width: CGFloat = 375.0
    static let iPhoneXWidth: CGFloat = 375.0
    static let iPhone11ProWidth: CGFloat = 414.0
    static let iPhone12ProWidth: CGFloat = 390.0
    static let iPhone14ProMaxWidth: CGFloat = 430.0
    
    // MARK: - Screen Comparison Methods
    static func isBiggerThan(height: CGFloat) -> Bool {
        screenHeight > height
    }
    
    static func isSmallerThan(height: CGFloat) -> Bool {
        screenHeight < height
    }
    
    static func isEqualTo(height: CGFloat) -> Bool {
        screenHeight == height
    }
    
    // MARK: - iPhone Specific Checks
    static var isIphone8: Bool {
        return isEqualTo(height: iPhone8Height)
    }
    
    static var isIphoneX: Bool {
        return isEqualTo(height: iPhoneXHeight)
    }
    
    static var isIphone11Pro: Bool {
        return isEqualTo(height: iPhone11ProHeight)
    }
    
    static var isIphone12Pro: Bool {
        return isEqualTo(height: iPhone12ProHeight)
    }
    
    static var isIphone14ProMax: Bool {
        return isEqualTo(height: iPhone14ProMaxHeight)
    }
    
    // MARK: - Safe Area Check
    static var hasBottomSafeArea: Bool {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first?
            .safeAreaInsets.bottom ?? 0 > 0
    }
    
    // MARK: - Orientation Checks
    static var isPortrait: Bool {
        return screenHeight > screenWidth
    }
    
    static var isLandscape: Bool {
        return screenWidth > screenHeight
    }
    
    // MARK: - Scale Factor
    static let screenScale: CGFloat = UIScreen.main.scale
    
    static var isRetina: Bool {
        return screenScale >= 2.0
    }
    
    // MARK: - Dynamic Type Support
    static let preferredContentSizeCategory = UIApplication.shared.preferredContentSizeCategory
    
    static func isAccessibilityCategory() -> Bool {
        return preferredContentSizeCategory.isAccessibilityCategory
    }
    
    static func isLargerThanLargeCategory() -> Bool {
        return preferredContentSizeCategory > .large
    }
}
