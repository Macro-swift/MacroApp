// swift-tools-version:5.1

import PackageDescription

let package = Package(
  
  name: "MacroApp",

  platforms: [
    .macOS(.v10_15), .iOS(.v13) // 10.15/13 is required for `some` to work
  ],
  
  products: [
    .library(name: "MacroApp", targets: [ "MacroApp" ]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/Macro-swift/Macro.git",
             from: "0.5.0"),
    .package(url: "https://github.com/Macro-swift/MacroExpress.git",
             from: "0.5.0")
  ],
  
  targets: [
    .target(name: "MacroApp",
            dependencies: [ "MacroCore", "MacroExpress" ]),
    .testTarget(name: "MacroAppTests", dependencies: ["MacroApp"])
  ]
)
