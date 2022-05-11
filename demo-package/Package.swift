// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "demo-package",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppCore",
            targets: ["AppCore"]),
        .library(
            name: "APIClient",
            targets: ["APIClient"]),
        .library(
            name: "Model",
            targets: ["Model"]),
        .library(
            name: "Screen1",
            targets: ["Screen1"]),
        .library(
            name: "Screen2",
            targets: ["Screen2"]),
        .library(
            name: "Screen3",
            targets: ["Screen3"]),
        .library(
            name: "Shared",
            targets: ["Shared"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "CombineSchedulers", url: "https://github.com/pointfreeco/combine-schedulers.git", .exact("0.5.3")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppCore",
            dependencies: [
                "APIClient",
                "Model",
                "Screen1",
                "Screen2",
                "Screen3",
                "CombineSchedulers",
                "Shared"
            ]),
        .target(
            name: "APIClient",
            dependencies: [
                "Model",
                "CombineSchedulers"
            ]),
        .target(
            name: "Model",
            dependencies: [
                "CombineSchedulers"
            ]),
        .target(
            name: "Screen1",
            dependencies: [
                "CombineSchedulers",
                "APIClient",
                "Screen2",
                "Shared"
            ]),
        .target(
            name: "Screen2",
            dependencies: [
                "CombineSchedulers",
                "APIClient",
                "Shared"
            ]),
        .target(
            name: "Screen3",
            dependencies: [
                "CombineSchedulers",
                "APIClient",
                "Shared"
            ]),
        .target(
            name: "Shared",
            dependencies: [
                "CombineSchedulers"
            ]),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]),
        .testTarget(
            name: "Screen1Tests",
            dependencies: ["Screen1"]),
        .testTarget(
            name: "Screen2Tests",
            dependencies: ["Screen2"]),
        .testTarget(
            name: "Screen3Tests",
            dependencies: ["Screen3"])
    ]
)
