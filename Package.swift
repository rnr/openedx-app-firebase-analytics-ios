// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OEXFirebaseAnalytics",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OEXFirebaseAnalytics",
            targets: ["OEXFirebaseAnalytics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rnr/openedx-app-foundation-ios", branch: "anton/iap-experiments"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.3.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.57.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OEXFirebaseAnalytics",
            dependencies: [
                .product(name: "OEXFoundation", package: "openedx-app-foundation-ios"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
        .testTarget(
            name: "OEXFirebaseAnalyticsTests",
            dependencies: ["OEXFirebaseAnalytics"]
        ),
    ]
)
