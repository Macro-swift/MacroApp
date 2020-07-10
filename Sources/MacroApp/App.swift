//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import MacroExpress

/**
 * The base protocol for MacroExpress "Apps", i.e. builder based middleware
 * setup.
 *
 * Usage:
 *
 *     @main
 *     struct MyApp: App {
 *
 *         var body : some Endpoints {
 *             Post("/findCow") { req, res, next in
 *                 res.send(cows.vaca())
 *             }
 *             Use { req, res, next in ...
 *             }
 *         }
 *     }
 *
 * Note: The `@main` attribute is available starting with Swift 5.3.
 *       In earlier versions, call `try MyApp.main()` in your tool.
 *
 * ## Sockets
 *
 * The app can implement the `port` property to return a custom port to be
 * used. The default implementation uses the `PORT` environment variable,
 * or `1337` if that isn't set.
 */
public protocol App {

  associatedtype Body : Endpoints
  
  #if swift(>=5.3)
    @EndpointsBuilder var body : Self.Body { get }
  #else
                      var body : Self.Body { get }
  #endif
  
  /**
   * Returns the port to be used.
   *
   * The default implementation checks the `PORT` environment variable,
   * if that is missing, 1337 is being used.
   */
  var port : Int? { get }
  
  init()
}

public extension App {

  var port : Int? {
    return process.getenv("PORT", defaultValue: 1337,
                          lowerWarningBound: 79, upperWarningBound: 2^16)
  }
}

public extension App {
  
  /**
   * Returns the `Express` application representing the `App` configuration.
   *
   * Can be used to attach a MacroApp to a larger Express application
   * (e.g. by mounting it).
   *
   * Example:
   *
   *     let cowsApp = try CowsApp().express()
   *     bigApp.use("/cows", cowsApp)
   *
   * There is also a `router.use(app)` extension.
   */
  func express() throws -> Express {
    let app = Express()
    try body.attachToRouter(app)
    return app
  }
  
  @usableFromInline internal func run() throws {
    let app  = try express()
    let port = self.port

    app.listen(port) {
      #if false // TODO: enable once ME is tagged
        express.log.notice("App started on port:", port)
      #else
        console.log("App started on port:", port)
      #endif
    }
    
    // This runs until all streams have finished.
    MacroCore.shared.run()
  }

  /**
   * Start the application (start listening on the socket)
   *
   * This never finishes.
   *
   * On Swift 5.3 the `main` function doesn't have do be invoked, instead the
   * `@main` attribute can be used like so:
   *
   *      @main HelloWorld: App { ... }
   *
   * In Swift 5.2 this can be used instead:
   *
   *      try HelloWorld.main()
   *
   */
  @inlinable
  static func main() throws {
    try Self().run()
  }
}
