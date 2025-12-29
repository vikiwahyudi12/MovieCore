// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MovieCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "MovieCore",
            targets: ["MovieCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.52.0"))
    ],
    targets: [
        .target(
            name: "MovieCore",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]),
        .testTarget(
            name: "MovieCoreTests",
            dependencies: ["MovieCore"]
        ),
    ]
)
