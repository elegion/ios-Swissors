// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swissors",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "Swissors",
            targets: ["Swissors"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/marksands/BetterCodable", "0.4.0"..."0.4.0")
    ],
    targets: [
        .target(
            name: "Swissors",
            dependencies: [
                "BetterCodable",
            ]
        ),
        .testTarget(
            name: "SwissorsTests",
            dependencies: [
                "Swissors",
                "BetterCodable",
            ],
            path: "Tests"
        )
    ]
)
