// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension PackageDescription.Target.Dependency {
    static let asset: Self = .product(name: "Asset", package: "Core")
    static let environment: Self = .product(name: "Environment", package: "Core")
    static let `extension`: Self = .product(name: "Extension", package: "Core")
    static let domainModel: Self = .product(name: "DomainModel", package: "Core")
    static let usecase: Self = .product(name: "Usecase", package: "Core")
    static let presentation: Self = "Presentation"
    static let wireframe: Self = "Wireframe"
    static let article: Self = "Article"
}

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Feature",
            targets: [
                "Article"
            ]
        ),
        .library(
            name: "Protocol",
            targets: [
                "Presentation",
                "Wireframe"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "Article",
            dependencies: [
                .presentation,
                .wireframe,
                .asset,
                .environment,
                .extension,
                .domainModel,
                .usecase
            ],
            path: "Sources/Article",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .target(
            name: "Presentation",
            path: "Sources/Presentation",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .target(
            name: "Wireframe",
            path: "Sources/Wireframe",
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-strict-concurrency=complete"
                    ]
                )
            ]
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: [
                .article,
                .environment,
                .domainModel
            ]
        )
    ]
)
