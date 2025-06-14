// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CashFlowFinderLibrary",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Shared", targets: ["Shared"]),
        .library(name: "Utils", targets: ["Utils"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppFeature",
            dependencies: ["Shared", "Utils"]),
        .target(
            name: "Shared"),
        .target(
            name: "Utils"),
    ]
)
