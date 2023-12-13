// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Feature",
            targets: [
                "Feature"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "Feature",
            dependencies: [
                "PresenterProtocol",
                "RouterProtocol",
                "ViewProtocol",
                .product(name: "Asset", package: "Core"),
                .product(name: "Enviroment", package: "Core"),
                .product(name: "Extension", package: "Core"),
                .product(name: "DomainModel", package: "Core"),
                .product(name: "Usecase", package: "Core")
            ],
            path: "Sources/Modules"
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
            dependencies: ["Feature"]
        ),
    ]
)
