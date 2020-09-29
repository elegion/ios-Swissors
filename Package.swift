// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swissors",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "Swissors",
            targets: ["Swissors"]),
    ],
    targets: [
        .target(
            name: "Swissors",
            dependencies: []),
        .testTarget(
            name: "SwissorsTests",
            dependencies: ["Swissors"]),
    ]
)
