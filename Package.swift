// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "Odio",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
  ],
  products: [
    .library(
      name: "Odio",
      targets: ["Odio"]),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", exact: "602.0.0"),
  ],
  targets: [
    .target(
      name: "Odio",
      dependencies: [
        "EntryMacros",
      ],
      swiftSettings: [
        SwiftSetting.swiftLanguageMode(.v6),
        SwiftSetting.defaultIsolation(MainActor.self),
        .enableExperimentalFeature("AccessLevelOnImport"),
        .enableExperimentalFeature("Macros"),
      ]),
    .macro(
      name: "EntryMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]),
  ])
