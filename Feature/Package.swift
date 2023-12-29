// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension PackageDescription.Target.Dependency {
    static let asset: Self = .product(name: "Asset", package: "Core")
    static let environment: Self = .product(name: "Environment", package: "Core")
    static let `extension`: Self = .product(name: "Extension", package: "Core")
    static let domainModel: Self = .product(name: "DomainModel", package: "Core")
    static let usecase: Self = .product(name: "Usecase", package: "Core")
    static let viewProtocol: Self = "ViewProtocol"
    static let presenterProtocol: Self = "PresenterProtocol"
    static let routerProtocol: Self = "RouterProtocol"
    static let article: Self = "Article"
    // Test
    static let quick: Self = "Quick"
    static let nimble: Self = "Nimble"
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
                "ViewProtocol",
                "PresenterProtocol",
                "RouterProtocol"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Core"),
        // Test
        .package(url: "https://github.com/Quick/Quick.git", from: "7.3.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "13.1.0"),
    ],
    targets: [
        .target(
            name: "Article",
            dependencies: [
                .viewProtocol,
                .presenterProtocol,
                .routerProtocol,
                .asset,
                .environment,
                .extension,
                .domainModel,
                .usecase
            ],
            path: "Sources/Article"
        ),
        .target(
            name: "ViewProtocol",
            path: "Sources/ViewProtocols"
        ),
        .target(
            name: "PresenterProtocol",
            path: "Sources/PresenterProtocols"
        ),
        .target(
            name: "RouterProtocol",
            path: "Sources/RouterProtocols"
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: [
                .article,
                .quick,
                .nimble
            ]
        )
    ]
)
