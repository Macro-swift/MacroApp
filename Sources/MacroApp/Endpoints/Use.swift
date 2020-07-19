//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import typealias MacroExpress.Middleware
import typealias MacroExpress.ErrorMiddleware

/**
 * `Use` adds an Endpoint, or old-style middleware to a `Router` (e.g. a `Route`
 * or an `Express` object).
 *
 * There is the usual set of associated method functions:
 * Get, Post, Put, Head, All etc. They all return preconfigured `Use` endpoints.
 *
 * Example:
 *
 *     MyApp: App {
 *         var body: some Endpoints {
 *
 *             Use(logger())
 *
 *             Use("/admin") { req, res, next in
 *                 console.log("hit admin endpoint ...")
 *                 next()
 *             }
 *         }
 *     }
 *
 */
public struct Use: RouteEndpoint {

  public let id              : String?
  public let pathPattern     : String?
  public let method          : HTTPMethod?
  public let middleware      : [ Middleware ]
  public let errorMiddleware : [ ErrorMiddleware ]

  @inlinable
  public init(id              : String?,
              pathPattern     : String?,
              method          : HTTPMethod?,
              middleware      : [ Middleware ],
              errorMiddleware : [ ErrorMiddleware ])
  {
    self.id              = id
    self.pathPattern     = pathPattern
    self.method          = method
    self.middleware      = middleware
    self.errorMiddleware = []
  }
}

public extension Use {

  @inlinable
  init(_ middleware: Middleware...) {
    self.init(id: nil, pathPattern: nil, method: nil,
              middleware: middleware, errorMiddleware: [])
  }
  
  @inlinable
  init(_ errorMiddleware: ErrorMiddleware...) {
    self.init(id: nil, pathPattern: nil, method: nil,
              middleware: [], errorMiddleware: errorMiddleware)
  }

  @inlinable
  init(id            : String?     = nil,
       _ pathPattern : String?     = nil,
       method        : HTTPMethod? = nil,
       _ middleware  : Middleware...)
  {
    self.init(id: id, pathPattern: pathPattern, method: method,
              middleware: middleware, errorMiddleware: [])
  }
  
  @inlinable
  init(id                : String?     = nil,
       _ pathPattern     : String?     = nil,
       method            : HTTPMethod? = nil,
       _ errorMiddleware : ErrorMiddleware...)
  {
    self.init(id: id, pathPattern: pathPattern, method: method,
              middleware: [], errorMiddleware: errorMiddleware)
  }
}
