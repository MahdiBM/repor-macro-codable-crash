// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let featureFlags: [SwiftSetting] = [
    /// `-enable-upcoming-feature` flags will get removed in the future
    /// and we'll need to remove them from here too.

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md
    /// Require `any` for existential types.
    .enableUpcomingFeature("ExistentialAny"),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md
    /// Nicer `#file`.
    .enableUpcomingFeature("ConciseMagicFile"),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0286-forward-scan-trailing-closures.md
    /// This one shouldn't do much to be honest, but shouldn't hurt as well.
    .enableUpcomingFeature("ForwardTrailingClosures"),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md
    /// `BareSlashRegexLiterals` not enabled since we don't use regex anywhere.

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0384-importing-forward-declared-objc-interfaces-and-protocols.md
    /// `ImportObjcForwardDeclarations` not enabled because it's objc-related.
]

let experimentalFeatureFlags: [SwiftSetting] = [
    /// `DiscordBM` passes the `complete` level.
    ///
    /// `minimal` / `targeted` / `complete`
    .enableExperimentalFeature("StrictConcurrency=complete"),
]

let swiftSettings = featureFlags + experimentalFeatureFlags

let package = Package(
    name: "repor-macro-codable-crash",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "repor-macro-codable-crash",
            targets: ["repor-macro-codable-crash"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "repor-macro-codable-crash",
            dependencies: [.target(name: "UnstableEnumMacro")],
            swiftSettings: swiftSettings
        ),
        .macro(
            name: "UnstableEnumMacro",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ],
            path: "./Macros/UnstableEnumMacro",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "repor-macro-codable-crashTests",
            dependencies: [
                .target(name: "repor-macro-codable-crash"),
                .target(name: "UnstableEnumMacro"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)
