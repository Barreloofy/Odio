// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
  targets: [
    .target(
      name: "Odio",
      swiftSettings: [
        SwiftSetting.swiftLanguageMode(.v6),
        SwiftSetting.defaultIsolation(MainActor.self),
      ]),
  ])
