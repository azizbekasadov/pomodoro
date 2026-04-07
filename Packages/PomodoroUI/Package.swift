// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "PomodoroUI",
    platforms: [.iOS(.v17), .macOS(.v12), .tvOS(.v17), .watchOS(.v10)],
    products: [
        .library(
            name: "PomodoroUI",
            targets: ["PomodoroUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.57.1")
    ],
    targets: [
        .target(
            name: "PomodoroUI",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
        .testTarget(
            name: "PomodoroUITests",
            dependencies: ["PomodoroUI"],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
    ]
)
