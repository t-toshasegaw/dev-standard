// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Asset",
            targets: ["Asset"]
        ),
        .library(
            name: "Extension",
            targets: ["Extension"]
        ),
        .library(
            name: "Enviroment",
            targets: ["Enviroment"]
        ),
        .library(
            name: "DomainModel",
            targets: ["DomainModel"]
        ),
        .library(
            name: "Usecase",
            targets: [
                "Usecase",
                "UseCaseContainer"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.0.0"),
        // Infra
        .package(url: "https://github.com/ishkawa/APIKit.git", from: "5.4.0"),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", from: "9.1.0"),
    ],
    targets: [
        // Asset
        .target(
            name: "Asset",
            path: "Sources/Assets"
        ),
        // Enviroment
        .target(name: "Enviroment"),
        // Extension
        .target(
            name: "Extension",
            dependencies: ["APIKit"],
            path: "Sources/Extensions"
        ),
        // Domain
        .target(
            name: "DomainModel",
            path: "Sources/Models"
        ),
        .target(
            name: "Repository",
            dependencies: ["DomainModel"],
            path: "Sources/Repositories"
        ),
        .target(
            name: "RepositoryContainer",
            dependencies: [
                "Infra",
                "Repository",
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "Usecase",
            dependencies: [
                "DomainModel",
                "RepositoryContainer",
                .product(name: "Dependencies", package: "swift-dependencies")
            ],
            path: "Sources/UseCases"
        ),
        .target(
            name: "UseCaseContainer",
            dependencies: [
                "Usecase",
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: []
        ),
        // Infra
        .target(
            name: "Infra",
            dependencies: [
                "APIKit",
                "DomainModel",
                "Extension",
                "Repository"
            ]
        ),
        .testTarget(
            name: "InfraTests",
            dependencies: [
                "Infra",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ]
        )
    ]
)
