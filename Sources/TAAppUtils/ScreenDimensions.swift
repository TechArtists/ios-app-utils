//
//  ScreenDimensions.swift
//  TAAppUtils
//
//  Created by Robert Tataru on 04.06.2025.
//


import UIKit

/// Utility for accessing screen and device-specific properties.
public enum ScreenDimensions {
    // MARK: - Screen Properties
    static public let screenWidth: CGFloat = UIScreen.main.bounds.width
    static public let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    // MAR publicK: - Device Heights
    static public let iPhone8Height: CGFloat = 667.0
    static public let iPhoneXHeight: CGFloat = 812.0
    static public let iPhone11ProHeight: CGFloat = 896.0
    static public let iPhone12ProHeight: CGFloat = 844.0
    static public let iPhone14ProMaxHeight: CGFloat = 932.0

    // MAR publicK: - Device Widths (for completeness)
    static public let iPhone8Width: CGFloat = 375.0
    static public let iPhoneXWidth: CGFloat = 375.0
    static public let iPhone11ProWidth: CGFloat = 414.0
    static public let iPhone12ProWidth: CGFloat = 390.0
    static public let iPhone14ProMaxWidth: CGFloat = 430.0
    
    // MARK: - Screen Comparison Methods
    static public func isBiggerThan(height: CGFloat) -> Bool {
        screenHeight > height
    }
    
    static public func isSmallerThan(height: CGFloat) -> Bool {
        screenHeight < height
    }
    
    static public func isEqualTo(height: CGFloat) -> Bool {
        screenHeight == height
    }
    
    // MARK: - iPhone Specific Checks
    static public var isIphone8: Bool {
        return isEqualTo(height: iPhone8Height)
    }
    
    static public  var isIphoneX: Bool {
        return isEqualTo(height: iPhoneXHeight)
    }
    
    static public  var isIphone11Pro: Bool {
        return isEqualTo(height: iPhone11ProHeight)
    }
    
    static public var isIphone12Pro: Bool {
        return isEqualTo(height: iPhone12ProHeight)
    }
    
    static public var isIphone14ProMax: Bool {
        return isEqualTo(height: iPhone14ProMaxHeight)
    }
    
    // MARK: - Safe Area Check
    static public var hasBottomSafeArea: Bool {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first?
            .safeAreaInsets.bottom ?? 0 > 0
    }
    
    // MARK: - Orientation Checks
    static public var isPortrait: Bool {
        return screenHeight > screenWidth
    }
    
    static public var isLandscape: Bool {
        return screenWidth > screenHeight
    }
    
    // MARK: - Scale Factor
    static let screenScale: CGFloat = UIScreen.main.scale
    
    static public var isRetina: Bool {
        return screenScale >= 2.0
    }
    
    // MARK: - Dynamic Type Support
    static public let preferredContentSizeCategory = UIApplication.shared.preferredContentSizeCategory
    
    static public func isAccessibilityCategory() -> Bool {
        return preferredContentSizeCategory.isAccessibilityCategory
    }
    
    static public func isLargerThanLargeCategory() -> Bool {
        return preferredContentSizeCategory > .large
    }
}
