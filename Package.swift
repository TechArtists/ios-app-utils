// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

private let packageName = "TAAppUtils"

let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: packageName,
            targets: [packageName]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: packageName,
            dependencies: []
        ),
    ]
)
