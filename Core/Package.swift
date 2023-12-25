// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Asset",
            targets: [
                "Asset"
            ]
        ),
        .library(
            name: "Extension",
            targets: [
                "Extension"
            ]
        ),
        .library(
            name: "Environment",
            targets: [
                "Environment"
            ]
        ),
        .library(
            name: "DomainModel",
            targets: [
                "DomainModel"
            ]
        ),
        .library(
            name: "Usecase",
            targets: [
                "Usecase"
            ]
        ),
        .library(
            name: "Infra",
            targets: [
                "Infra"
            ]
        )
    ],
    dependencies: [
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
        // Environment
        .target(
            name: "Environment",
            dependencies: [
                "Usecase"
            ]
        ),
        // Extension
        .target(
            name: "Extension",
            dependencies: [
                "APIKit"
            ],
            path: "Sources/Extensions"
        ),
        // Domain
        .target(
            name: "DomainModel",
            path: "Sources/Models"
        ),
        .target(
            name: "Repository",
            dependencies: [
                "DomainModel"
            ],
            path: "Sources/Repositories"
        ),
        .target(
            name: "Usecase",
            dependencies: [
                "DomainModel",
                "Repository"
            ],
            path: "Sources/UseCases"
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
