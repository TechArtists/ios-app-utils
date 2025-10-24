//
//  EnvConfig.swift
//  
//
//  Created by Robert Tataru on 24.10.2025.
//


import Foundation
import StoreKit

// swiftlint:disable identifier_name
enum AppConfiguration {
    case Debug
    case TestFlight
    case AppStore
}

struct EnvConfig {
    
    /// Detects if the app is running in TestFlight environment
    /// Uses multiple detection methods for better reliability across iOS versions
    static var isTestFlight: Bool {
        // Method 1: Receipt URL check (still works on iOS 18, though deprecated)
        // This remains the most reliable method for TestFlight detection
        if let receiptURL = Bundle.main.appStoreReceiptURL {
            if receiptURL.lastPathComponent == "sandboxReceipt" {
                return true
            }
        }
        
        // Method 2: Environment variable check (TestFlight often sets this)
        if let testFlightEnv = ProcessInfo.processInfo.environment["TESTFLIGHT"],
           testFlightEnv == "1" {
            return true
        }
        
        // Method 3: Check if running in simulator (for testing purposes)
        #if targetEnvironment(simulator)
        return false // Simulator is not TestFlight
        #endif
        
        return false
    }
    
    /// Detects if the app is running in Debug mode
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// Returns the current app configuration based on environment
    static var appConfiguration: AppConfiguration {
        if isDebug {
            return .Debug
        } else if isTestFlight {
            return .TestFlight
        } else {
            return .AppStore
        }
    }
    
    /// Async method to detect sandbox environment using StoreKit (iOS 15+)
    /// This is the modern approach recommended by Apple for future iOS versions
    @available(iOS 15.0, *)
    static func detectSandboxEnvironmentAsync() async -> Bool {
        do {
            // Check if any current transactions are in sandbox environment
            for await result in Transaction.currentEntitlements {
                switch result {
                case .verified(let transaction):
                    return transaction.environment == .sandbox
                case .unverified:
                    continue
                }
            }
            
            // Fallback to AppTransaction if no entitlements exist
            let appTransactionResult = try await AppTransaction.shared
            switch appTransactionResult {
            case .verified(let appTransaction):
                return appTransaction.environment == .sandbox
            case .unverified:
                return false
            }
        } catch {
            // If StoreKit fails, fall back to receipt URL method
            return Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        }
    }
}
