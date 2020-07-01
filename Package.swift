// swift-tools-version:5.1

import PackageDescription

let package = Package(
  
  name: "MacroApp",

  platforms: [
    .macOS(.v10_14), .iOS(.v11)
  ],
  
  products: [
    .library(name: "MacroApp", targets: [ "MacroApp" ]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/Macro-swift/Macro.git",
             from: "0.1.0"),
    .package(url: "https://github.com/Macro-swift/MacroExpress.git",
             from: "0.0.6")
  ],
  
  targets: [
    .target(name: "MacroApp",
            dependencies: [ "MacroCore", "MacroExpress" ])
  ]
)
