// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PomodoroDomain",
    products: [
        .library(
            name: "PomodoroDomain",
            targets: ["PomodoroDomain"]
        ),
    ],
    targets: [
        .target(
            name: "PomodoroDomain"
        ),
        .testTarget(
            name: "PomodoroDomainTests",
            dependencies: ["PomodoroDomain"]
        ),
    ]
)
