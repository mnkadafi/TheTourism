// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Destination",
  platforms: [.iOS(.v14), .macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Destination",
      targets: ["Destination"])
  ],
  dependencies: [
    .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "5.4.4"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
    .package(path: "/Users/mojave/Documents/Xcode/TheTourism/Module/Core")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Destination",
      dependencies: [
        .product(name: "RealmSwift", package: "Realm"),
        "Core",
        "Alamofire"
      ]),
    .testTarget(
      name: "DestinationTests",
      dependencies: ["Destination"])
  ]
)
