// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Patrick",
    platforms: [
        .iOS(.v12), .macOS(.v10_15)
    ],
    products: [
        .library(name: "Patrick", targets: ["Patrick"]),
    ],
    targets: [
        .target(name: "Patrick", path: "Patrick"),
        .testTarget(name: "PatrickTests", dependencies: ["Patrick"]),
    ]
)
