// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension PackageDescription.Target.Dependency {
    static let asset: Self = "Asset"
    static let environment: Self = "Environment"
    static let `extension`: Self = "Extension"
    static let domainModel: Self = "DomainModel"
    static let usecase: Self = "Usecase"
    static let repository: Self = "Repository"
    static let infra: Self = "Infra"
    static let apiKit: Self = "APIKit"
    // Test
    static let ohhttpStubs: Self = .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
}

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
                "Environment",
                "MockEnvironment"
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
        // Test
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", from: "9.1.0")
    ],
    targets: [
        // Asset
        .target(
            name: "Asset",
            path: "Sources/Assets",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        // Environment
        .target(
            name: "Environment",
            dependencies: [
                .usecase
            ],
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .target(
            name: "MockEnvironment",
            dependencies: [
                .environment,
                .usecase,
                .domainModel
            ],
            path: "Tests/MockEnvironment"
        ),
        // Extension
        .target(
            name: "Extension",
            dependencies: [
                .apiKit
            ],
            path: "Sources/Extensions",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        // Domain
        .target(
            name: "DomainModel",
            path: "Sources/Models",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .target(
            name: "Repository",
            dependencies: [
                .domainModel
            ],
            path: "Sources/Repositories",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .target(
            name: "Usecase",
            dependencies: [
                .domainModel,
                .repository
            ],
            path: "Sources/Usecases",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .testTarget(
            name: "DomainTests"
        ),
        // Infra
        .target(
            name: "Infra",
            dependencies: [
                .apiKit,
                .domainModel,
                .extension,
                .repository
            ],
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .testTarget(
            name: "InfraTests",
            dependencies: [
                .infra,
                .ohhttpStubs
            ]
        )
    ]
)
