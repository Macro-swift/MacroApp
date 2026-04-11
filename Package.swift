// swift-tools-version:6.0

import PackageDescription

let package = Package(
  
  name: "MacroApp",

  platforms: [  .macOS(.v15), .iOS(.v18) ],
  
  products: [
    .library(name: "MacroApp", targets: [ "MacroApp" ]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/Macro-swift/Macro.git",
             from: "1.0.46"),
    .package(url: "https://github.com/Macro-swift/MacroExpress.git",
             from: "1.0.46")
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
