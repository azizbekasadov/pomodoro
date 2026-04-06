// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PomodoroDomain",
    platforms: [.iOS(.v17), .macOS(.v12), .tvOS(.v17), .watchOS(.v10)],
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
