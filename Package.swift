// swift-tools-version:5.2

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
             from: "0.8.11"),
    .package(url: "https://github.com/Macro-swift/MacroExpress.git",
             from: "0.8.8")
  ],
  
  targets: [
    .target(name: "MacroApp", dependencies: [ 
      .product(name: "MacroCore", package: "Macro"), 
      "MacroExpress"
    ]),
    .testTarget(name: "MacroAppTests", dependencies: [ 
      .product(name: "MacroTestUtilities", package: "Macro"),
      "MacroApp"
    ])
  ]
)
