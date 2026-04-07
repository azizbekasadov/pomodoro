// swift-tools-version: 6.1

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
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.57.1")
    ],
    targets: [
        .target(
            name: "PomodoroDomain",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
        .testTarget(
            name: "PomodoroDomainTests",
            dependencies: ["PomodoroDomain"],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
    ]
)
