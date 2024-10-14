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
        .package(url: "https://github.com/raccoongang/openedx-app-foundation-ios.git", branch: "73836f22f165d114e07e309a01a5cbcd8103dbec"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OEXFirebaseAnalytics",
            dependencies: [
                .product(name: "OEXFoundation", package: "openedx-app-foundation-ios"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "OEXFirebaseAnalyticsTests",
            dependencies: ["OEXFirebaseAnalytics"]
        ),
    ]
)
