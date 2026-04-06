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
    targets: [
        .target(
            name: "PomodoroUI"
        ),
        .testTarget(
            name: "PomodoroUITests",
            dependencies: ["PomodoroUI"]
        ),
    ]
)
