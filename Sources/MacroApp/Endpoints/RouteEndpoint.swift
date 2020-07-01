//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import enum      NIOHTTP1.HTTPMethod
import typealias MacroExpress.Middleware
import typealias MacroExpress.ErrorMiddleware
import protocol  MacroExpress.RouteKeeper
import class     MacroExpress.Route

// Those are all the same ..., essentially a replica of RouteKeeper.swift

public protocol RouteEndpoint: Endpoints {
  
  typealias HTTPMethod = NIOHTTP1.HTTPMethod
  
  var id              : String?             { get }
  var pathPattern     : String?             { get }
  var middleware      : [ Middleware      ] { get }
  var errorMiddleware : [ ErrorMiddleware ] { get }
  var method          : HTTPMethod?         { get }

  var route           : MacroExpress.Route  { get }
}

public extension RouteEndpoint {
  @inlinable var id              : String?             { return nil }
  @inlinable var pathPattern     : String?             { return nil }
  @inlinable var method          : HTTPMethod?         { return nil }
  @inlinable var middleware      : [ Middleware      ] { return []  }
  @inlinable var errorMiddleware : [ ErrorMiddleware ] { return []  }
}
extension RouteEndpoint {
  
  @inlinable
  public var route : MacroExpress.Route {
    return .init(id: id, pattern: pathPattern, method: method,
                 middleware      : middleware,
                 errorMiddleware : errorMiddleware)
  }
  
  @inlinable
  public func attachToRouter(_ router: RouteKeeper) throws {
    router.add(route: route)
  }
}
